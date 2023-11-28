const User = require("../models/user");
const jwt = require("jsonwebtoken");
const signUp = async (req, res) => {
  try {
    const { name, email, profilePic } = req.body;
    let user = await User.findOne({ email: email });
    if (!user) {
      user = new User({
        email: email,
        name: name,
        profilePic: profilePic,
      });
      user = await user.save();
    }
    const token = jwt.sign({ id: user._id }, "THISISASECRET");
    res.status(200).json({ user, token: token });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

const getUserData = async (req, res) => {
  const user = await User.findById(req.user);
  if (user) return res.status(200).json({ user, token: req.token });
  else return res.status(500).json({ message: "User not found" });
};

module.exports = { signUp, getUserData };
