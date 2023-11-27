const mongoose = require("mongoose");

const userSchema = mongoose.Schema({
  name: {
    type: String,
    required: true,
    min: 3,
    max: 20,
  },
  email: {
    type: String,
    required: true,
    unique: true,
  },
  profilePic: {
    type: String,
    required: true,
  },
});

module.exports = mongoose.model("User", userSchema);
