const express = require('express');
const cors = require('cors');

const recipesRoute = require('./routes/recipesRoute');

require('dotenv').config();
require('./config/database');

const app = express();

app.use(express.json());
app.use(express.urlencoded({extended: true}));
app.use(cors());

app.get('/', (req, res) => {
      res.send('Hello, Express!');
});

app.use('/api/recipes', recipesRoute);

const PORT = process.env.PORT;


// Start the server
app.listen(PORT, () => {
  console.log(`Server is running at http://localhost:${PORT}`);
});