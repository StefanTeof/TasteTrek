const express = require('express');
const cors = require('cors');
const passport = require('passport');

const recipesRoute = require('./routes/recipesRoute');
const usersRoute = require('./routes/users');
const favoritesRoute = require('./routes/favoritesRoute');

require('dotenv').config();
require('./config/database');
require('./config/passport');

const app = express();

app.use(express.json());
app.use(express.urlencoded({extended: true}));
app.use(cors());
app.use(passport.initialize());

app.use('/api/recipes', recipesRoute);
app.use('/api/users', usersRoute);
app.use('/api/favorites', favoritesRoute);

const PORT = process.env.PORT;


// Start the server
app.listen(PORT, () => {
  console.log(`Server is running at http://localhost:${PORT}`);
});