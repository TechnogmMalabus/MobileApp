const express = require('express');
const app = express();
const cors = require('cors');
const bodyParser = require('body-parser');
app.use(cors())
app.use(bodyParser.json());
const userRoutes = require('./routes/user.routes');
const agencyRoutes = require('./routes/agency.routes');
const adminRoutes = require('./routes/admin.routes');
const stationRoutes = require('./routes/station.routes')
const ligneRoutes = require('./routes/ligne.routes')

//routes users
app.use('/user', userRoutes);

//routes agency
app.use('/agency', agencyRoutes);

//routes admin
app.use('/admin', adminRoutes);

//routes station
app.use('/station' , stationRoutes)


//routes ligne
app.use('/ligne' , ligneRoutes)


module.exports = app;