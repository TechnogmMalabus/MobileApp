const Agency = require('../models/agency.models')
const Station = require('../models/station.models')
const Reservation = require('../models/reservation.models')
const Voyage = require('../models/voyage.models')
const Ligne = require('../models/ligne.models')
const Arret = require('../models/arret.models')
const Infoligne = require('../models/info-ligne.models')
const sendToken = require('../utils/JWT_Tokenagency');
const ErrorHandler = require('../utils/errorHandler');
const catchAsyncErrors = require('../middleware/catchAsyncErrors');
const sendEmail = require('../utils/sendEmail')
const crypto = require('crypto')
var generator = require('generate-password');
//register agency
exports.registerAgency = async (req, res,next) => {
    try{
    const { nameagency,
        matricule,
        email,
        num_cnss,
        business_sector,
        legal_status,
        password } = req.body;

    const agency = await Agency.create({
        nameagency,
        matricule,
        email,
        num_cnss,
        business_sector,
       legal_status,
       password
    })    
    res.status(200).json({
        success: true,
        message: `Your account has been added successfully You must wait for the acceptance by the administrator`,
        return : agency
    }
    )
   // res.status(200).json(agency)
}catch(e){
    console.log(e.message)
    return res.status(400).json({ "error":e.message.replace(/nameagency:|Agency validation failed:|matricule:|email:|num_cnss:|business_sector:|legal_status:/,'') });
     }  
}
//login agency
exports.loginAgency = async (req, res, next) => {
    const password = req.body.password;
    const credentels = req.body.credentels;
     var agency;
    //verfy name and password agency
    if (!credentels || !password) {
        return res.status(404).json({ error :"Veuillez entrer votre nom d'utilisateur ou email et votre mot de passe"})    

    }
    if (credentels.indexOf('@') === -1) {
        agency = await Agency.findOne({ nameagency:credentels }).select('+password')
       if (!agency) {
        return res.status(404).json({error :"Username ou Email incorrect"})
    }
   }else{
    agency = await Agency.findOne({ email:credentels }).select('+password')
       if (!agency) {
        return res.status(404).json({ error:"Email ou username incorrect"})
    }
   }
    //verify account is actif or not
    if(agency.verified == false){
        return res.status(404).json({ error :"Vous n'avez pas encore verifier"})
    }
    const ipasswordMatched = await agency.comparePassword(password);
    if (!ipasswordMatched) {
        return res.status(404).json({error: "Mot de passe incorrect"})
    }
    sendToken(agency, 200, res)
}
//Forget password
exports.forgotPassword = catchAsyncErrors(async (req, res, next) => {
    const agency = await Agency.findOne({ email: req.body.email });
    if (!agency) {
       // return next(new ErrorHandler('Email not found...!', 404));
     //  return res.status(404).send(
      //  "email incorrect"
   // )
   return res.status(404).json({ error: 'email not found' });
    }
    const resetToken = agency.getResetPasswordToken();
    await agency.save({ validateBeforeSave: false });
    const resetUrl = `${req.protocol}://${req.get('host')}/password/reset/${resetToken}`;
    const message = 
    `You asked us to reset your forgotten password.
     To complete the process, please click on the link below or paste 
     it into your browser:\n\n${resetUrl}\n\n`
    try {
        await sendEmail({
            email: agency.email,
            subject: 'MalaBus password ',
            message
        })
        res.status(200).json({
            success: true,
            message: `Email sent to: ${agency.email}`
        })
    } catch (error) {
      //  agency.resetPasswordToken = undefined;
       // agency.resetPasswordExpire = undefined;
       // await agency.save({ validateBeforeSave: false });
       // return next(new ErrorHandler(error.message, 500));
       return res.status(500).json({ error: error.message });
    }
})
//Reset password
exports.resetPassword = catchAsyncErrors(async (req, res, next) => {
    const resetPasswordToken = crypto.createHash('sha256').update(req.params.token).digest('hex')
    const agency = await Agency.findOne({
        resetPasswordToken,
        resetPasswordExpire: { $gt: Date.now() }
    })

    if (!agency) {
        return next(new ErrorHandler('Matricule reset token is invalid or has been expired', 400))
    }

    if (req.body.matricule !== req.body.confirmMatricule) {
        return next(new ErrorHandler('Matricule does not match', 400))
    }
    agency.matricule = req.body.matricule;
    agency.resetPasswordToken = undefined;
    agency.resetPasswordExpire = undefined;
    await agency.save();
    sendToken(agency, 200, res)
})
//loged agency
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
//find agency by id
exports.getAgencyProfil= async(req,res)=>{
    try {
    const agency = await Agency.findById(req.params.id)
    res.status(200).json(agency)
} 
catch (err) {
    res.status(500).json(err)
  }
}
// Update agency profile 
exports.updateProfile = catchAsyncErrors(async (req, res) => {
    const newAgency = {
        nameagency: req.body.nameagency,
        email: req.body.email,
        num_cnss : req.body.num_cnss,
        business_sector:req.body.business_sector,
        legal_status:req.body.legal_status
    }
    const agency = await Agency.findByIdAndUpdate(req.params.id, newAgency, {
        new: true,
        runValidators: true,
        useFindAndModify: false
    })
    sendToken(agency, 200, res)
})
// liste reservation
exports.getReservation= async(req,res)=>{
    try {
    const reservationList = await Reservation.find()
    res.status(200).json(reservationList)
}
catch (err) {
    res.status(500).json(err)
  }
}
// liste voyage
exports.getAllvoyage= async(req,res)=>{
    try {
    const voyageList = await Voyage.find()
    res.status(200).json(voyageList)
}
catch (err) {
    res.status(500).json(err)
  }
}
//ajout voyage
exports.ajoutVoyage = async (req , res  )=>{
    try{
        const {
            nomAgence,ligne , datettst , heureDepart ,heureDep, minDep, heureArrive, durée ,prix , nbPlaces , escale ,type_voyage, distance 
        }= req.body ;
        /*
        const yearSyst = new Date().getUTCFullYear()
        const monthSyst = new Date().getUTCMonth()+1
        const daySyst = new Date().getUTCDate()
        console.log(yearSyst)
        console.log(monthSyst)
        console.log(daySyst)
        console.log("************")
        const year = new Date(dateVoyage).getUTCFullYear()
        const month = new Date(dateVoyage).getUTCMonth()+1
        const day = new Date(dateVoyage).getUTCDate()+1
        console.log(year)
        console.log(month)
        console.log(day)
        console.log("************")
        const yearRestant = yearSyst-year
        const monthRestant = month-monthSyst
        const dayRestant = day-daySyst
        console.log('il vous reste : ',dayRestant,'jours',monthRestant,'mois',yearRestant,'années')
        console.log(yearRestant)
        console.log(monthRestant)
        console.log(dayRestant)
        const hrsSyst = new Date().getHours()-1
        const minSyst = new Date().getMinutes()
        const secSyst = new Date().getSeconds()
        console.log("************")
        console.log(hrsSyst)
        console.log(minSyst)
        console.log(secSyst)
        const heure = parseInt(heureDepart)
        console.log("************")
        console.log(heure)
        const heureRestant = heure - hrsSyst
        console.log("************")
        console.log(heureRestant)

*/
        const dateVoyage = new Date(datettst).setUTCHours(heureDep , minDep)
        const logoAgence = await Agency.find({nameagency : req.body.nomAgence} , {imagePath:1 })
        const lignArret  = await Station.find({ligne : req.body.ligne} , {arret:1 , _id:0 })
        //voyage de type aller
        if(type_voyage == "Aller"){
            const arret = lignArret[0].arret
            const imagePath = logoAgence[0].imagePath
            const voyage = await Voyage.create ({
                nomAgence,ligne, arret ,escale,imagePath, dateVoyage  , heureDepart , heureArrive,durée, prix , nbPlaces , type_voyage , distance
            })
            res.send({
                message : "votre voyage ajouter avec succées ",
                voyage 
            })
        }
        //voyage de type retour
        else{
            const arret = lignArret[0].arret.reverse()
            const voyage = await Voyage.create ({
                nomAgence,ligne, arret , escale, dateVoyage , heureDepart , heureArrive,durée, prix , nbPlaces , type_voyage
            })
            res.send({
                message : "votre voyage ajouter avec succées ",
                voyage 
            })
        }
     
    }
   
    catch (e){
        console.log(e.message)
    }
}
//liste voyage 
exports.listeVoyage = async (req, res) => {
    const {nomAgence} = req.body
    const voyage = await Voyage.find({nomAgence})
    res.status(200).json(voyage)
}
// modifier voyage
exports.updateVoyage = async (req , res) => {
    const newVoyage = {
        ligne : req.body.ligne ,
        villeArriver : req.body.villeArriver,
        dateVoyage : req.body.dateVoyage,
        heureDepart : req.body.heureDepart,
        heureArrive : req.body.heureArrive ,
        durée : req.body.durée,
        prix : req.body.prix,
        nbPlaces : req.body.nbPlaces,
        escale : req.body.escale,
        distance : req.body.distance
    }
    const voyage = await Voyage.findByIdAndUpdate(req.params.id, newVoyage, {
        new: true,
    })
    const emailVoyageur = await Reservation.find(req.params.id_Voyage).select('email_User')
    if(emailVoyageur.length != 0){
        const message =
        `Votre voyage a été modifier par l'agence`
         sendEmail({
            email: emailVoyageur,
            subject: 'Notification de modification voyage',
            message
        })
          res.status(200).json({
            success: true,
            message: `Email sent to: ${emailVoyageur}`,
            voyage : voyage
        })
    }
    else{
        res.status(200).json({
            success: true,
            voyage : voyage
        })
    }
 

}
// annuler voyage
exports.annulerVoyage = async (req, res) => {
    const voyage = await Voyage.findByIdAndDelete(req.params.id)
    const emailVoyageur = await Reservation.find(req.params.id_Voyage).select('email_User')
  if(emailVoyageur.length !=0){
    const message =
    `Votre reservation du voyage a été annuler merci de rechercher un autre voyage  `
    await sendEmail({
        email: emailVoyageur,
        subject: 'Annulation du voyage',
        message
    })
    res.status(200).json({
        success: true,
        message: `Email sent to: ${emailVoyageur}`,
        voyage : voyage
    })
  }
  else{
    res.status(401).json({
        success: false
    })
  }
}
//Update image profile
exports.updateProfileImage = catchAsyncErrors(async (req, res) => {
    const newImage = {
        imagePath : 'http://localhost:3000/images/' + req.file.filename
    }
    const user = await Agency.findByIdAndUpdate(req.params.id, newImage, {
        new: true,
        runValidators: true,
        useFindAndModify: false
    })
    return res.status(201).json('Logo ajouter')
})



/**Sprint ligne */
//create-ligne
exports.ajouterLigne = async (req, res) => {
    var regExpLigne = /([A-Z]|[a-z])(-)([A-Z]|[a-z])/;
    const { nom_ligne } = req.body;
    var testReg = regExpLigne.test(nom_ligne)
    if (testReg == true){
        var exist_ligne ;
        exist_ligne = await Ligne.find({nom_ligne})
        if(exist_ligne.length == 0 ){
            const nomLigne = await Ligne.create({
                nom_ligne
            })    
             res.status(200).json({
                success: true,
                message: `ligne ajouter`,
                return : nomLigne
            }
            )
        }
        else {
            return res.status(404).json("Ligne déja existe")
        }
    }
    else{
        return res.status(404).json("Mauvais format devriez écrire comme ceci Stop1-Stop2")}
  
    
}
//create arret
exports.ajouterArret = async (req, res,next) => {
    const { nom_arret , longitude , latitude } = req.body;
    var exist_arret ;
    exist_arret = await Arret.find({nom_arret})
    if(exist_arret.length == 0 ){
        const nomArret = await Arret.create({
            nom_arret , longitude , latitude
        })    
         res.status(200).json({
            success: true,
            message: `arret ajouter`,
            return : nomArret
        }
        )
    }
    else {
   
        return res.status(404).json("arret déja existe")
    }
}

//getLigne 
exports.getAllLigne = async (req , res ) => {
    try {
        const ligneList = await Ligne.find()
        res.status(200).json(ligneList)
    }
    catch (err) {
        res.status(500).json(err)
      }
}
//getArret 
exports.getAllArret = async (req , res ) => {
    try {
        const arretList = await Arret.find()
                res.status(200).json(arretList)
    }
    catch (err) {
        res.status(500).json(err)
      }
}

//create information ligne 
exports.ajouterInfoLigne = async (req, res,next) => { 
    const info_arret ={ 
         nom_ligne , arretligne   , prix , distance , type_distance ,
         unite_prix,
        num_bus, duree , nbr_place
     } = req.body.data;
     if (nom_ligne.length==0){
        return res.status(404).json("Vous devez sélectionner une ligne")
    }
    if (prix.length==0){
        return res.status(404).json("Prix de ligne est obligatoire")
    }
    if (distance.length==0){
        return res.status(404).json("Saisi de la distance est obligatoire")
    }
    if (type_distance.length==0){
        return res.status(404).json("La distance est manquant leur type")
    }
    if (num_bus.length==0){
        return res.status(404).json("Numéro de bus est obligatoire")
    }
    if (duree.length==0){
        return res.status(404).json("Duré de la ligne est obligatoire")
    }
        const infoLigne = await Infoligne.create({
            id_agence: req.params.id_agence, nom_ligne , arretligne: req.body.arretligne   ,
             prix :prix.concat(' ', unite_prix), unite_prix,
            distance: distance.concat(' ', type_distance),type_distance,
            num_bus, duree , nbr_place
        })
         res.status(200).json({
            success: true,
            message: 'infoLigne ajouter',
            return : infoLigne
        }
        )

}
//getAllinfoligne
exports.getAllInfoLigne = async (req , res ) => {
    try {
        const infoligne = await Infoligne.find()
        res.status(200).json(infoligne)
    }
    catch (err) {
        res.status(500).json(err)
      }
}

//modifierInfoligne
exports.updateInfoLigne = catchAsyncErrors(async (req, res) => {
    const newInfoLigne = {
        nom_ligne: req.body.nom_ligne,
        arretligne : req.body.arretligne,
        heur_dep:req.body.heur_dep,
        heur_arriv:req.body.heur_arriv,
        prix:req.body.prix,
        distance:req.body.distance,
        num_bus:req.body.num_bus,
        duree:req.body.duree,
        nbr_place:req.body.nbr_place,
    }
    const infoLigneupdate = await Infoligne.findByIdAndUpdate(req.params.id, newInfoLigne, {
        new: true,
        runValidators: true,
        useFindAndModify: false
    })
    res.status(200).json({
        success: true,
        message: `infoLigne modifer`,
        return : infoLigneupdate
    }
    )
})

//supprimerInfoligne
exports.deleteInfoligne= async(req,res)=>{
    try {
        const infoligne = await Infoligne.findById(req.params.id);
        !infoligne && res.status(404).json("ligne not found");
        await infoligne.deleteOne();
        res.status(200).json("info ligne supprimé");
} 
catch (err) {
    res.status(500).json(err)
  }
}

//getarretparID
exports.findarretById = async (req, res, next) => {
    const arret = await Arret.findById(req.params.id)
    return res.status(200).json(arret)
}



//getAllligneparID
exports.findallligneById = async (req, res, next) => {
    const id_agence = req.params.id_agence
    const ligneInfobyid = await Infoligne.find({id_agence : id_agence})
    console.log(ligneInfobyid);
    return res.status(200).json(ligneInfobyid)
}

//getpayload 
exports.getarret = async (req, res , next) =>{
    let payload = req.body.payload 
    res.send({payload})
}
