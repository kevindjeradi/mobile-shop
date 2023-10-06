require("dotenv").config();
const express = require("express");
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
// importing user context
const User = require("./model/user");
const Cards = require("./model/cards");
const article = require("./model/article");
const auth = require("./middleware/auth");
const db = require("./config/database")
const app = express();

app.use(express.json());

// Logic goes here

app.post("/welcome", auth, (req, res) => {
    res.status(200).send("Welcome 🙌 ");
  });

// Register
app.post("/users/register", async (req, res) => {

    try {
        // Get user input
        const { first_name, last_name, email, password } = req.body;
        console.log(req.body.first_name)
        console.log(req.body.last_name)
        console.log(req.body.email)
        console.log(req.body.password)
        // Validate user input
        if (!(email && password && first_name && last_name)) {
          res.status(400).send("All inputs are required");
        }
    
        // check if user already exist
        // Validate if user exist in our database
        const oldUser = await User.findOne({ email });
    
        if (oldUser) {
          return res.status(409).send("User Already Exist. Please Login");
        }
    
        //Encrypt user password
        encryptedPassword = await bcrypt.hash(password, 10);
    
        // Create user in our database
        const user = await User.create({
          first_name,
          last_name,
          email: email.toLowerCase(), // sanitize: convert email to lowercase
          password: encryptedPassword,
        });
    
        // Create token
        const token = jwt.sign(
          { user_id: user._id, email },
          process.env.TOKEN_KEY,
          {
            expiresIn: "2h",
          }
        );
        // save user token
        user.token = token;
    
        // return new user
        res.status(201).json(user);
      } catch (err) {
        console.log(err);
      }
      // Our register logic ends here

});

// Login
app.post("/users/login", async (req, res) => {

    try {
        // Get user input
        const email = req.body.email;
        const password = req.body.password;
    
        // Validate user input
        if (!(email && password)) {
          res.status(400).send("All input is required");
        }

        // Validate if user exist in our database
        const user = await User.findOne({ email });
        const bcpass = await bcrypt.compare(password, user.password)
        if (user && bcpass) {
          // Create token
          const token = jwt.sign(
            { user_id: user._id, email },
            process.env.TOKEN_KEY,
            {
              expiresIn: "2h",
            }
          );
        
          // save user token
          user.token = token;
          // user
          res.status(200).json(user);
        }
        else
        {
            res.status(400).send("Invalid Credentials");
        }
      } catch (err) {
        console.log(err);
      }

});

// addCard
app.post("/users/addCard", async (req, res) => {

  try {
      // Get user input
      const email = req.body.email;
      const cardNumber = req.body.cardNumber;
      const expiryDate = req.body.expiryDate;
      const cvvCode = req.body.cvvCode;
      const cardHolder = req.body.cardHolder;

      // Validate if user exist in our database
      const user = await User.findOne({ email });
      if (user) {
        const card = await Cards.create({
          holderEmail: user.email,
          cardHolder: cardHolder,
          cardNumber: cardNumber,
          expiryDate: expiryDate,
          cvvCode: cvvCode,
        });
        res.status(201).json(card);
      }
      else
      {
          res.status(400).send("Card could not be created");
      }
    } catch (err) {
      console.log(err);
    }
});


//Get card by holderId
app.get("/users/getCards/:holderEmail", db.getCardsByHolderEmail);

// Articles
// Create an article
app.post("/article/create", async (req, res) => {

    try {
        // Get user input
        const { nom, image, description, prix, barcode } = req.body;
        // Validate article input
        if (!(nom && image && description && prix)) {
          res.status(400).send("All inputs are required");
        }
    
        // Create article in our database
        const _article = await article.create({
          nom,
          image,
          description,
          prix,
          barcode
        });

        // return new article
        res.status(201).json(_article);
      } catch (err) {
        console.log(err);
      }

});

// updateSolde
app.post("/users/addSolde", db.updateSolde);

// get all articles
app.get("/article", db.getArticles);

app.get("/article/getByBarcode/:code", db.getArticlesbyBarcode);

module.exports = app;