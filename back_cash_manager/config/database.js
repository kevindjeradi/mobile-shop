const mongoose = require("mongoose");
const article = require("../model/article");
const cards = require("../model/cards");
const user = require("../model/user");

const { MONGO_URI } = process.env;

  // Connecting to the database
  mongoose
    .connect(MONGO_URI, {
      useNewUrlParser: true,
      useUnifiedTopology: true,
    })
    .then(() => {
      console.log("Successfully connected to database");
    })
    .catch((error) => {
      console.log("database connection failed. exiting now...");
      console.error(error);
      process.exit(1);
    });

    const updateSolde = async (req, res) => {
      try {
        let solde;
        const newSolde = req.body.solde;
        const email = req.body.email;
        const type = req.body.type;
        const User =  await user.findOne({ email });
        console.log(User)
        console.log(newSolde);
        console.log(email);
        if (user)
        {
          if (type == "plus")
          {
            solde = User.solde + newSolde;
          }
          else if (type == "minus"){
            if (User.solde - newSolde >= 0.0)
            {
              solde = User.solde - newSolde;
            }
          }
          result = await user.updateOne(
            {"email": email},
            {$set: {'solde': solde}},
          );
          console.log(`${result.matchedCount} document(s) matched the filter, updated ${result.modifiedCount} document(s)`,);  
          console.log(User)
          res.status(200).json(User);
        }
      } catch (err) {
        console.log(err);
      }  
    }

    const getArticles = (req, res) => {
      article.find({}).exec(function(err, result) {
        if (err) throw err;
        console.log(result);
        res.status(200).json(result);
      });
    }

    const getArticlesbyBarcode = (req, res) => {
      const code = req.params["code"];
      console.log(code);
      article.find({barcode: code}).exec(function(err, result) {
        if (err) throw err;
        console.log("----------------------------");
        console.log(result);
        if (result)
        {
          return res.status(200).json(result);
        }
        res.status(404).json(result);
      });
    }

    const getCardsByHolderEmail = (req, res) => {
      const holderEmail = req.params["holderEmail"];
      console.log(holderEmail);
      cards.find({holderEmail: holderEmail}).exec(function(err, result) {
        if (err) throw err;
        console.log("----------------------------");
        console.log(result);
        if (result)
        {
          return res.status(200).json(result);
        }
        res.status(404).json(result);
      });
    }


    module.exports = {
      updateSolde,
      getArticles,
      getArticlesbyBarcode,
      getCardsByHolderEmail
    }

