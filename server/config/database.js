const mongoose = require('mongoose')
require('dotenv').config();


const connectDb = mongoose.connect(process.env.DATABASE_CONNECTION_STRING, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
    })
  .then(() => console.log('Connected to MongoDB'))
  .catch((err) => console.log(err));


module.exports = connectDb;