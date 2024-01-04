const express = require('express');
const router = express.Router();
const UserController = require('../controllers/user.controllers');
const { isAuthenticatedUser } = require('../middleware/auth');
const {isVerifiedEmail,isVerifiedPassword} = require('../middleware/auth');
const storage = require('../helpers/storage');

//Routes user
router.post('/register',isVerifiedPassword,UserController.registerUser)
router.get("/confirm/:confirmationCode", UserController.verifyUser)
router.get('/findUserByEmail/:email', UserController.findUserByEmail)
router.post('/login', UserController.loginUser)
router.get('/logout', UserController.logout)
router.post('/password/forgetpassword', UserController.forgotPassword)
router.put('/password/reset/:token' , UserController.resetPassword)
router.get('/getProfil/:id' , isAuthenticatedUser, UserController.getUserProfil)
router.put('/updateProfil/:id' ,isAuthenticatedUser, UserController.updateProfile)
router.put('/updateprofilImage/:id' , storage ,isAuthenticatedUser, UserController.updateProfileImage)
router.get('/rechercheReservation' , UserController.findReservation);
router.post('/ajout_reservation' , UserController.ajoutreservation);
router.get('/liste_reservation_user' , UserController.listeReservationUser);
router.post('/recherche_voyage' , UserController.rechercheVoyage);

// user route mobile
router.post('/loginMobile', UserController.loginUserMobile)
router.post('/registerMobile',isVerifiedEmail, isVerifiedPassword,UserController.registerUserMobile)
router.post('/forgetpasword',isVerifiedEmail,UserController.forgotPasswordMobile)
router.post('/sms', UserController.sendsms)
router.post('/verify',isVerifiedEmail, isVerifiedPassword,UserController.verifyUserMobile)
router.get('/getProfilMobile/:id' ,  UserController.getUserProfilMobile)
router.put('/updateProfilMobile/:id' , UserController.updateProfileMobile)
router.post('/arretCordinate' ,  UserController.getArretCordinate)



module.exports = router;