const User = require('../models/user.models');
const Voyage = require('../models/voyage.models');
const Arret = require('../models/arret.models');
const Reservation = require('../models/reservation.models');
const ErrorHandler = require('../utils/errorHandler');
const config = require("../config/auth.config");
const sendToken = require('../utils/JWT_Token');
const catchAsyncErrors = require('../middleware/catchAsyncErrors');
const sendEmail = require('../utils/sendEmail')
const crypto = require('crypto')
const bcrypt = require('bcryptjs')
const genUsername = require("unique-username-generator");
var jwt = require("jsonwebtoken");
const nodemailer = require("../config/nodemailer.config");
const Voyagee = require('../models/voyageresult.models').Voyagee;
//const {Voyagee} = require('../models/voyageresult.models')
const accountSid = process.env.TWILIO_ACCOUNT_SID;
const authToken = process.env.TWILIO_AUTH_TOKEN;
const client = require('twilio')(accountSid, authToken);
var generator = require('generate-password');
var ObjectId = require('mongodb').ObjectId;

//register user
exports.registerUser = async (req, res, next) => {

    var id_user = "#";
    var userExist;
    const token = jwt.sign({ email: req.body.email }, config.secret)
    try {   
        const { fname, lname, username,
             phoneNum, email,
            password, job, civility,
            address, postalCode, city,birthday = birthday.toISOString().split('T')[0],
            country } = req.body;
        const confirmationCode = token;
        userExist = await User.findOne({ email: req.body.email })
        if (userExist) {
            return res.status(404).send("utilisateur déja inscrit")
        }
        id_user = id_user + genUsername.generateFromEmail(email, 3)
        const user = await User.create({
            fname, lname, username,
            birthday, phoneNum, email,
            password, job, civility,
            address, postalCode, city,
            country, id_user,
            imagePath,
            confirmationCode
        })
        res.send({
            message:
                "User was registered successfully! Please check your email",
        });
        nodemailer.sendConfirmationEmail(
            user.username,
            user.email,
            user.confirmationCode
        );
    } catch (e) {
        console.log(e.message)
        return res.status(400).json({ "error": e.message.replace(/fname:|User validation failed:|lname:|username:|birthday:|phoneNum:|address:|postalCode:/gi, '') });
    }
}
//register user mobile
exports.registerUserMobile = async (req, res, next) => {
    var id_user ="#";
    var userExist;
    
    try{
  
    const { fname, lname, username,
        birthday, phoneNum, email,
        password, job, civility,
        address, postalCode, city,
        country,status } = req.body;
        userExist = await User.findOne({ email:req.body.email })
        if (userExist) {
            return res.status(401).json({ error: 'user already exist' });
        }
        
        id_user = id_user + genUsername.generateFromEmail(email,3) 
        const user = await User.create({
            fname, lname, username,
            birthday, phoneNum, email,
            password, job, civility,
            address, postalCode, city,
            country,id_user,status
        })

        res.status(200).json(user);
        console.log(user)
    }
    catch(e){
        console.log(e.message)
        return res.status(400).json({ "error":e.message.replace(/fname:|User validation failed:|lname:|username:|birthday:|phoneNum:|address:|postalCode:/gi,'') });

    }
}
//login user mobile
exports.loginUserMobile = (async (req, res, next) => {
    console.log(req.body);
     const password= req.body.password;
     const credentels = req.body.email;
     var user;

    if (!credentels || !password) {
        //return next(new ErrorHandler('Please enter your Username or email and Password..!', 400))
        return res.status(400).json({ error: 'Please enter your Username or email and Password' });
        
    }
    if (credentels.indexOf('@') === -1) {
         user = await User.findOne({ username:credentels }).select('+password')
        if (!user) {
            return res.status(401).json({ error: 'Invalid Username or Password' });
          //  return next(new ErrorHandler('Invalid Username or Password', 401));
        }
    }else{
         user = await User.findOne({ email:credentels }).select('+password')
        if (!user) {
         //   return next(new ErrorHandler('Invalid email or Password', 401));
         return res.status(401).json({ error: 'Invalid Username or Password' });
         
        }
    }
    const isPasswordMatched = await user.comparePassword(password);
    if (!isPasswordMatched) {
       // return next(new ErrorHandler('Invalid Password', 401));
        return res.status(401).json({ error: 'Invalid Password' });
    }
    sendToken(user, 200, res)
})
//forget password mobile
exports.forgotPasswordMobile = catchAsyncErrors(async (req, res, next) => {
    const user = await User.findOne({ email: req.body.email });
    if (!user) {
        return res.status(404).json({ error: 'email not found' });
    }
    const newPassword  = generator.generate({
        length: 10,
        numbers: true,
        symbols:true,
        lowercase:true,
        uppercase:true,
        exclude:" "
    });

    hachedPassword = await bcrypt.hash(newPassword, 10)
    const updatedUser = await User.findOneAndUpdate({ email: req.body.email }, {
        $set: {
            password:hachedPassword
        }
    })
    const message =
        `this is a new password please use it to sign in and then change it :\n\n${newPassword}\n\n`
    try {
        await sendEmail({
            email: user.email,
            subject: 'MalaBus password ',
            message
        })
        res.status(200).json({
            success: true,
            message: `Email sent to: ${user.email}`
        })
    } catch (error) {
        return res.status(500).json({ error: error.message });
    }
})
// send sms
exports.sendsms = catchAsyncErrors(async (req, res) => {
    var smsCode
    phone=req.body.phoneNum
try{
    smsCode= Math.floor(Math.random() * (99999 - 10000 )) + 10000+""
    client.messages
  .create({
     body:  `This is the verification code from Malabus ${smsCode} `,
     from: '+17854652514',
     to: '+216'+phone
   })
  .then(message => console.log(message.sid));
    
    res.status(200).json({
        code: smsCode
    })
}catch(e){
    console.log(e)
    res.status(400).json({
        success: "error"
    })
}
})
// verify user mobile
exports.verifyUserMobile = catchAsyncErrors(async (req, res) => {
    var id_user ="#";
    var userExist;
try{

    const { fname, lname, username,
        birthday, phoneNum, email,
        password, job, civility,
        address, postalCode, city,
        country,status } = req.body;
        userExist = await User.findOne({ email:req.body.email })
        if (userExist) {
            return res.status(401).json({ error: 'user already exist' });
        }
        id_user = id_user + genUsername.generateFromEmail(email,3) 
        const user = await User.create({
            fname, lname, username,
            birthday, phoneNum, email,
            password, job, civility,
            address, postalCode, city,
            country,id_user,status
        }) 
        await user.deleteOne();
    res.status(200).json({
        verified: true
    })
}catch(e){
    
     return res.status(400).json({ "error":e.message.replace(/fname:|User validation failed:|lname:|username:|birthday:|phoneNum:|address:|postalCode:/gi,'') });
        
   
}
})
// get profil mobile
exports.getUserProfilMobile= async(req,res)=>{
    try {
    const user = await User.findById(req.params.id)
    res.status(200).json(user)
} 
catch (err) {
    res.status(500).json(err)
  }
}

// Update user profile mobile
exports.updateProfileMobile = catchAsyncErrors(async (req, res) => {
    try{
    const newUser = {
        fname: req.body.fname,
        lname: req.body.lname,
       // username : req.body.username,
        birthday:req.body.birthday,
        phoneNum:req.body.phoneNum,
        job:req.body.job,
        civility:req.body.civility,
        address:req.body.address,
       // postalCode:req.body.postalCode,
      //  city:req.body.city,
       // country: req.body.country,
        email: req.body.email,
    }
    const user = await User.findByIdAndUpdate(req.params.id, newUser, {
        new: true,
        runValidators: true,
        useFindAndModify: false
    })
    res.status(200).json({
        success: true
    })
}
    catch(e){
        console.log(e.message)
        return res.status(400).json({ "error":e.message.replace(/fname:|User validation failed:|lname:|username:|birthday:|phoneNum:|address:|postalCode:/gi,'') });
    }
    
})


//find user by email
exports.findUserByEmail = async (req, res, next) => {
    const user = await User.findOne({ email: req.params.email })
    if (!user) {
        return res.status(404).send("Username ou Email incorrect")
    } else {
        // res.status(200).json(user)
        return sendToken(user, 200, res)

    }
}
//login user 
exports.loginUser = (async (req, res, next) => {
    const password = req.body.password;
    const credentels = req.body.credentels;
    var user;
    if (!credentels || !password) {
        return res.status(404).send("Veuillez entrer votre nom d'utilisateur ou email et votre mot de passe")
    }
    if (credentels.indexOf('@') === -1) {
        user = await User.findOne({ username: credentels }).select('+password')
        if (!user) {
            return res.status(404).send("Username ou Email incorrect")
        }
        if (user.status != "Active") {
            return res.status(404).send("Votre compte n'est pas encore activé")
        }

    } else {
        user = await User.findOne({ email: credentels }).select('+password')
        if (!user) {
            return res.status(404).send("Email ou username incorrect")
        }
        if (user.status != "Active") {
            return res.status(404).send("Votre compte n'est pas encore activé")
        }
    }
    const isPasswordMatched = await user.comparePassword(password);
    if (!isPasswordMatched) {
        return res.status(404).send("Mot de passe incorrect")
    }
    sendToken(user, 200, res)
})
//loged user
exports.logout = catchAsyncErrors(async (req, res, next) => {
    res.cookie('token', null, {
        expires: new Date(Date.now()),
        httpOnly: true
    })
    res.status(200).json({
        success: true,
        message: 'Logged out'
    })
})
//Forget password
exports.forgotPassword = catchAsyncErrors(async (req, res, next) => {
    const user = await User.findOne({ email: req.body.email });
    if (!user) {
        return res.status(404).send(
            "email incorrect"
        )
    }
    const resetToken = user.getResetPasswordToken();
    console.log(resetToken);
    await user.save({ validateBeforeSave: false });
    // const resetUrl = `${req.protocol}://${req.get('host')}/password/reset/${resetToken}`;
    const resetUrl = `https://localhost:4200/forgetpassword/resetPassword?token=${resetToken}`

    const message =
        `Vous nous avez demandé de réinitialiser votre mot de passe oublié.
             Pour terminer le processus, veuillez cliquer sur le lien ci-dessous ou coller
             dans votre navigateur :\n\n${resetUrl}\n\n`
    try {
        await sendEmail({
            email: user.email,
            subject: 'MalaBus password ',
            message
        })
        res.status(200).json({
            success: true,
            message: `Email sent to: ${user.email}`
        })
    } catch (error) {
        user.resetPasswordToken = undefined;
        user.resetPasswordExpire = undefined;
        await user.save({ validateBeforeSave: false });
        return next(new ErrorHandler(error.message, 500));
    }
})
//Reset Password
exports.resetPassword = catchAsyncErrors(async (req, res, next) => {
    // Hash URL token
    const resetPasswordToken = crypto.createHash('sha256').update(req.params.token).digest('hex')
    const user = await User.findOne({
        resetPasswordToken,
        resetPasswordExpire: { $gt: Date.now() }
    })
    if (!user) {
        return res.status(400).send("User incorecte")
    }
    if (req.body.password !== req.body.confirmPassword) {
        return res.status(400).send("Mot de passe incorecte")
    }
    // Setup new password
    user.password = req.body.password;
    user.resetPasswordToken = undefined;
    user.resetPasswordExpire = undefined;
    await user.save();
    sendToken(user, 200, res)
})
//find user by id
exports.getUserProfil = async (req, res) => {
    try {
        const user = await User.findById(req.params.id)
        res.status(200).json(user)
    }
    catch (err) {
        res.status(500).json(err)
    }
}
// Update user profile 
exports.updateProfile = catchAsyncErrors(async (req, res) => {
    const newUser = {
        fname: req.body.fname,
        lname: req.body.lname,
        birthday: req.body.birthday,
        phoneNum: req.body.phoneNum,
        job: req.body.job,
        civility: req.body.civility,
        address: req.body.address,

    }
    const user = await User.findByIdAndUpdate(req.params.id, newUser, {
        new: true,
        runValidators: true,
        useFindAndModify: false
    })
     sendToken(user, 200, res)
})
//verifyuser
exports.verifyUser = async (req, res, next) => {
    const user = await User.findOne({ confirmationCode: req.params.confirmationCode })
    if (!user) {
        return res.status(404).send({ message: "User Not found." });
    }
    user.status = "Active";
    user.save((err) => {
        if (err) {
            return res.status(500).send({ message: err });
        }
        res.status(200).json(user)
    });
}
//Update image profile
exports.updateProfileImage = catchAsyncErrors(async (req, res) => {
    const newUser = {
        imagePath : 'http://localhost:3000/images/' + req.file.filename
    }
    const user = await User.findByIdAndUpdate(req.params.id, newUser, {
        new: true,
        runValidators: true,
        useFindAndModify: false
    })
    return res.status(201).json('Photo de profil changer')
})
//recherche reservation
exports.findReservation = async (req, res) => {
  const {dateVoyage , arretDepart , arretArrive  } = req.body
  const reservation = await Voyage.find(  {dateVoyage , "arret": {$all:[arretArrive ,arretDepart]} , nbPlaces : {$ne : 0} }).select('-_id').select('-type_voyage').select('-dateVoyage').select('-escale._id')

  if(reservation.length==0){
         console.log('Aucune résultat trouvé');
        return res.status(404).json({ error:"Aucune résultat trouvé"})
        

    }
    
    else{
        console.log('reservation:', reservation);
        return  res.status(200).json(reservation)
        
    }
}
//ajouter reservation
exports.ajoutreservation = async (req , res  )=>{
    try{
        const {
            email_User , numTel , id_Voyage , fname , lname , nbPlace
        }= req.body ;
         //nombre de place restant du voyage reservé
         const nbPlacesrestant = await Voyage.find({_id : req.body.id_Voyage},{nbPlaces : 1 , _id:0})
        //nombre de place  supérieur npmbre de place restant 
         if(nbPlace > nbPlacesrestant[0].nbPlaces){
             return res.status(401).json("Nombre des places restants n'est pas sufissantes")
         }
         //nombre de place  inférieur npmbre de place restant 
        const reservation = await Reservation.create ({
            email_User, numTel, id_Voyage , fname , lname , nbPlace
        })
        const updateNbplace = await Voyage.findByIdAndUpdate({_id : req.body.id_Voyage}, {$inc : {nbPlaces : -nbPlace}})
        res.send({
            message : "votre reservation ajouter avec succées ",
            reservation
        })
    }
    catch (e){
        console.log(e.message)
    }
}
//consulter liste de leur reservation
exports.listeReservationUser = async (req, res) => {
    const listeReservation = await Reservation.find({email_User : req.body.email_User})
    res.status(200).json(listeReservation)
}

/* exports.rechercheVoyage = async (req , res) => {
    const {dateVoyage ,arretDepart,arretArrive   } = req.body
console.log(dateVoyage)
    try {
        const voyageExiste = await Voyage.find()
        if(voyageExiste.length==0){
            return res.status(404).send("Aucune résultat trouvé")
    }
    
     else{
        return res.status(200).send(voyageExiste)
    }
   
    } 
    catch (error) {
        res.status(400).send(error)
    }
   
   
    
} */
 exports.rechercheVoyage = async (req , res) => {
    const {dateVoyage ,arretDepart,arretArrive   } = req.body
    
    
    const voyageExiste = await Voyage.find({dateVoyage , "arretligne.nom_arret" : {$all:[arretDepart ,arretArrive]} })
   
    if(voyageExiste.length==0){
            console.log({voyageExiste,dateVoyage , "arretligne.nom_arret" : {$all:[arretDepart ,arretArrive]} })
            return res.status(404).json({error :"Aucune résultat trouvé"})
    }
    
     else{
        
        var listeVoyage = [];
         var id  
         var nomLigne 
         var dateDeVoyage
         var Nbrtickets 
         var numBus 
         var arretDeDepart 
         var arretDeArrive
         var heurDepart 
         var heurArrive 
         var distance 
         var prix
         var arrets 
         var duree 
         var h1
         var m1
         var h2
         var m1
         var h
         var m    
        
        for(var i= 0; i < voyageExiste.length; i++)
{
    const indexDepart = voyageExiste[i].arretligne.findIndex(object => {
        return object.nom_arret == arretDepart;
        
      });
      const indexArrive = voyageExiste[i].arretligne.findIndex(object => {
        return object.nom_arret == arretArrive;
        
      });
      
      id=voyageExiste[i]._id
      nomLigne=voyageExiste[i].nom_ligne
      dateDeVoyage=voyageExiste[i].dateVoyage
      Nbrtickets=voyageExiste[i].Nbrtickets
      numBus=voyageExiste[i].num_bus
      arretDeDepart=arretDepart
      arretDeArrive =arretArrive

     
// si aller
      if(indexDepart<indexArrive){
        console.log("aller");
        const eleDep=voyageExiste[i].arretligne[indexDepart]
        if(eleDep.heure_depart!="")
        {
            console.log("heur depar "+eleDep.heure_depart);
            heurDepart=eleDep.heure_depart
        }
        else
        {
             console.log("heur depar "+eleDep.heure_arrive)
             heurDepart=eleDep.heure_arrive
    }
        //console.log(voyageExiste[i].arretligne[indexDepart]);

        const eleArr=voyageExiste[i].arretligne[indexArrive]
        if(eleArr.heure_depart!=""){
            console.log("heur arrive "+eleArr.heure_depart);
            heurArrive=eleArr.heure_depart
        }else
        { 
            console.log("heur arrive "+eleArr.heure_arrive)
            heurArrive=eleArr.heure_arrive
        }
        //calcul distance
        distanceDepart = parseInt(eleArr.distance.replace(' ','').replace('km',''));
        distancAarrive = parseInt(eleDep.distance.replace(' ','').replace('km',''));
        distanceTotal= Math.abs(distancAarrive - distanceDepart)
        console.log("distance totale  "+distanceTotal)
        distance=distanceTotal
        //calcul prix
        prixDepart = parseInt(eleArr.prix.replace(' ','').replace('dt',''));
        prixAarrive = parseInt(eleDep.prix.replace(' ','').replace('dt',''));
        if(prixDepart==prixAarrive)
        {
            console.log("prix totale  "+prixDepart)
            prix=prixDepart
        }
        else
        {
            prixTotal= Math.abs(prixDepart - prixAarrive)
            console.log("prix totale  "+prixTotal)
            prix=prixTotal
        }
        // tableus des arrets entre 2 arret
        console.log("//////////////////");
        console.log(voyageExiste[i].arretligne.slice(indexDepart,indexArrive+1));
        console.log("//////////////////");
        arrets=voyageExiste[i].arretligne.slice(indexDepart,indexArrive+1)
      }else
      { 
        // si retour
        console.log("retour");
        const eleArrr=voyageExiste[i].arretligne[indexDepart]
        if(eleArrr.heure_depart_retour!=""){
            console.log("heur depar "+eleArrr.heure_depart_retour);
            heurDepart= eleArrr.heure_depart_retour
        }
        else{ 
            console.log("heur depar "+eleArrr.heure_depart_arrive)
            heurDepart= eleArrr.heure_depart_arrive
    }
       
        const eleArrdep=voyageExiste[i].arretligne[indexArrive]
        if(eleArrdep.heure_depart_retour!=""){
            console.log("heur arrive "+eleArrdep.heure_depart_retour);
            heurArrive =eleArrdep.heure_depart_retour
        }else{ 
            console.log("heur arrive "+eleArrdep.heure_depart_arrive)
            heurArrive =eleArrdep.heure_depart_arrive
        }
        //calcul distance
        distanceDepart = parseInt(eleArrr.distance.replace(' ','').replace('km',''));
        distancAarrive = parseInt(eleArrdep.distance.replace(' ','').replace('km',''));
        distanceTotal= Math.abs(distancAarrive - distanceDepart)
        console.log("distance totale  "+distanceTotal)
        distance=distanceTotal
        //calcul prix
        prixDepart = parseInt(eleArrr.prix.replace(' ','').replace('dt',''));
        prixAarrive = parseInt(eleArrdep.prix.replace(' ','').replace('dt',''));
        if(prixDepart==prixAarrive)
        {
            console.log("prix totale  "+prixDepart)
            prix=prixDepart
        }else
        {
            prixTotal= Math.abs(prixDepart - prixAarrive)
            console.log("prix totale  "+prixTotal)
            prix=prixTotal
        }
         // tableus des arrets entre 2 arret
         console.log("//////////////////");
         console.log((voyageExiste[i].arretligne.slice(indexArrive,indexDepart+1)).reverse());
         console.log("//////////////////");
         arrets = (voyageExiste[i].arretligne.slice(indexArrive,indexDepart+1)).reverse()
        
    }
    ///////////
    
    h1=parseInt(heurDepart.substring(0, 2))
    m1=parseInt(heurDepart.substring(3))
    h2=parseInt(heurArrive.substring(0, 2))
    m2=parseInt(heurArrive.substring(3))
    
    if (h2-h1<=0) {
      h=(h2-h1)+24
    } else {
      h=h2-h1
    }
    
    if (m2-m1<0) {
      m=(m2-m1)+60
      if (m==60) {
        h+=1
        m=0
      }
    } else {
      m=m2-m1
    }
    var duree=h+"h "+m+"m"
    console.log(duree)
    
    //////////

    const voyageFound= new Voyagee (
         id,
         nomLigne, 
         dateDeVoyage,
         Nbrtickets ,
         numBus ,
         arretDeDepart, 
         arretDeArrive,
         heurDepart, 
         heurArrive, 
         distance, 
         prix,
         arrets ,
         duree    
    )
    listeVoyage.push(voyageFound)
    console.log("///////voyage from classe///////////");
    console.log(voyageFound);
    console.log("///////voyage from classe///////////");
    
}
       
      //  res.status(200).json(voyageExiste)
      res.status(200).json(listeVoyage)
    } 
}
 

// get arret latlang by voyage id

exports.getArretCordinate = async (req , res  )=>{
    var listid = [];
    //var listarret = [];
    var arrets;
    try{
        const {id_Voyage,arretDepart,arretArrive }= req.body ;

        console.log('id_Voyage:', id_Voyage);
        console.log('arretDepart:', arretDepart);
        console.log('arretArrive:', arretArrive);
         //get voyage by id
         const voyage = await Voyage.findById(id_Voyage)

         const indexDepart = voyage.arretligne.findIndex(object => {
            return object.nom_arret == arretDepart;
            
          });
          const indexArrive =voyage.arretligne.findIndex(object => {
            return object.nom_arret == arretArrive;
            
          });
          //si aller
          if(indexDepart<indexArrive){
    
              arrets=voyage.arretligne.slice(indexDepart,indexArrive+1)
              for(var i= 0; i < arrets.length; i++){
                listid.push(arrets[i].id) ;
              }
            }else
            {
                arrets = (voyage.arretligne.slice(indexArrive,indexDepart+1)).reverse()
                for(var i= 0; i < arrets.length; i++){
                    listid.push(arrets[i].id) ;
                  }
             }

             // liste des arret
             var obj_ids = listid.map(function(id) { return ObjectId(id); });
            listarret = await Arret.find({_id: {$in: obj_ids}});

            var stack = [];

            for (var i =  obj_ids.length - 1; i > 0; i--) {
            
                var rec = {
                    "$cond": [
                        { "$eq": [ "$_id",  obj_ids[i-1] ] },
                        i
                    ]
                };
            
                if ( stack.length == 0 ) {
                    rec["$cond"].push( i+1 );
                } else {
                    var lval = stack.pop();
                    rec["$cond"].push( lval );
                }
            
                stack.push( rec );
            
            }
            
            var pipeline = [
                { "$match": { "_id": { "$in":  obj_ids } }},
                { "$project": { "weight": stack[0],"nom_arret":1,"longitude":1,"latitude":1,"duree_arret":1 }},
                { "$sort": { "weight": 1 } }
            ];
            
            listarret = await Arret.aggregate( pipeline ); 
            console.log('listid:', listid);
            console.log('arrets:', arrets);
            

       
         res.status(200).json(arrets);
         console.log('listarret:', listarret);


    }
    catch (e){
        console.error(e.message);
        res.status(500).json({ error: 'An error occurred' });
    }
}





