const mongoose = require("mongoose");

const cardsSchema = new mongoose.Schema({
  cardNumber: { type: String },
  expiryDate: { type: String },
  cvvCode: { type: String },
  cardHolder: { type: String },
  holderEmail: { type: String },
});

module.exports = mongoose.model("cards", cardsSchema);