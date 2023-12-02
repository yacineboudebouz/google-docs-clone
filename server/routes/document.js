const express = require("express");
const auth = require("../middlewares/auth.");

const documentRouter = express.Router();
const { create } = require("../controllers/document");

documentRouter.post("/create", auth, create);

module.exports = documentRouter;
