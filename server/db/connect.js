const mongoose = require("mongoose");

const dotenv = require("dotenv");

dotenv.config();

connectionString = process.env.CONNECTION_URL;

const connectDB = async () => {
  return mongoose
    .connect(connectionString, {
      useNewUrlParser: true,
      useUnifiedTopology: true,
    })
    .then(() => {
      console.log("Connected to the database !");
    })
    .catch((error) => {
      console.log("Unable to connect to the database !");
      console.log(error);
    });
};

module.exports = connectDB;
