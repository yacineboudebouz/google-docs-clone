const express = require("express");
const auth = require("../middlewares/auth.");

const documentRouter = express.Router();
const {
  create,
  getAllDocuments,
  update,
  getById,
} = require("../controllers/document");

documentRouter.post("/create", auth, create);
documentRouter.get("/all/me", auth, getAllDocuments);
documentRouter.post("/title", auth, update);
documentRouter.get("/:id", auth, getById);

module.exports = documentRouter;
