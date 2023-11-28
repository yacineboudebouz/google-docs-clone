const express = require("express");
const auth = require("../middlewares/auth.");

const authRouter = express.Router();
const { signUp, getUserData } = require("../controllers/user");

authRouter.post("/signup", signUp);
authRouter.get("/", auth, getUserData);

module.exports = authRouter;
