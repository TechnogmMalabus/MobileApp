const mongoose = require('mongoose')
const ArretSchema = new mongoose.Schema({
    nom_arret: {
        type: String,
    },
    longitude : {
        type: Number,
    },
    latitude : {
        type: Number,
    },
    
})
module.exports = mongoose.model('Arret', ArretSchema);