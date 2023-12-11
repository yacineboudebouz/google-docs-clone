const Document = require("../models/document");

create = async (req, res) => {
  try {
    const { createdAt } = req.body;
    let document = new Document({
      uid: req.user,
      title: "Untitled Document",

      createdAt: createdAt,
    });
    document = await document.save();
    res.status(201).json(document);
  } catch (e) {
    res.status(500).json({ message: e.message });
  }
};

update = async (req, res) => {
  try {
    const { id, title } = req.body;
    const document = await Document.findByIdAndUpdate(id, { title });
    res.status(200).json(document);
  } catch (e) {
    res.status(500).json({ message: e.message });
  }
};

getAllDocuments = async (req, res) => {
  try {
    const documents = await Document.find({ uid: req.user });
    res.status(200).json(documents);
  } catch (e) {
    res.status(500).json({ message: e.message });
  }
};

getById = async (req, res) => {
  try {
    const id = req.params.id;
    const document = await Document.findById(id);
    res.status(200).json(document);
  } catch (e) {
    res.status(500).json({ message: e.message });
  }
};

module.exports = { create, getAllDocuments, update, getById };
