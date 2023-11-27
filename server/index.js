const express = require("express");
const app = express();
const dotenv = require("dotenv");
const mongoose = require("mongoose");
const authRouter = require("./routes/user");
const connectDB = require("./db/connect");
dotenv.config();

const port = 3000;

const start = async () => {
  try {
    await connectDB();
    app.listen(port, () => {
      console.log(`Server is listening on port ${port}...`);
    });
  } catch (error) {
    console.log(error);
  }
};

start();

app.use(express.json());
app.use("/api/auth", authRouter);
