const mongoose = require("mongoose");

const articleSchema = new mongoose.Schema({
  nom: { type: String, default: null },
  image: { type: String, default: null },
  description: { type: String, default: null },
  prix: { type: String },
  barcode: { type: String, default: null },
});

module.exports = mongoose.model("article", articleSchema);