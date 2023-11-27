const User = require("../models/user");

const signUp = async (req, res) => {
  try {
    const { name, email, profilePic } = req.body;
    var user = await User.findOne({ email: email });
    if (!user) {
      user = new User({
        email: email,
        name: name,
        profilePic: profilePic,
      });
      user = await user.save();
      res
        .status(201)
        .json({ message: "User created successfully", user: user });
    } else {
      res.status(403).json({ message: "User already exists" });
    }
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

module.exports = { signUp };
