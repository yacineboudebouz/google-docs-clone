const express = require("express");
const auth = require("../middlewares/auth.");

const documentRouter = express.Router();
const { create, getAllDocuments } = require("../controllers/document");

documentRouter.post("/create", auth, create);
documentRouter.get("/all/me", auth, getAllDocuments);

module.exports = documentRouter;
