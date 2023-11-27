const express = require("express");

const authRouter = express.Router();
const { signUp } = require("../controllers/user");

authRouter.post("/signup", signUp);

module.exports = authRouter;
