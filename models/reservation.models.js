const mongoose = require('mongoose')
const ReservationSchema = new mongoose.Schema({
    email_User: {
        type: String
    },
    lname: {
        type: String
    },
    fname: {
        type: String
    },
    nbPlace: {
        type: Number
    },
    numTel:{
        type : Number
    },
    id_Voyage:{
        type: String
    }
})
module.exports = mongoose.model('Reservation', ReservationSchema);