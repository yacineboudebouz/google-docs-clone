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

module.exports = { create };