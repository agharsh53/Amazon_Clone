const jwt = require("jsonwebtoken");
const User = require("../model/user");

const admin = async (req, res, next) => {
  try {
    // Retrieve the token from request header
    const stamp = req.header('stamp');
    if (!stamp) {
      return res.status(401).json({ msg: "No validation token. Unauthorized." });
    }

    // Verify the token
    let verifyStamp;
    try {
      verifyStamp = jwt.verify(stamp, "secretKey");
    } catch (error) {
      return res.status(401).json({ msg: "Token verification failed. Unauthorized access." });
    }

    // Retrieve the user from the database
    const user = await User.findById(verifyStamp.id);
    if (!user) {
      return res.status(404).json({ msg: "User not found." });
    }

    // Check if the user is an admin (you may replace this with your actual condition)
    // if (!user.isAdmin) { // Assuming isAdmin is a boolean field in your user model
    //   return res.status(403).json({ msg: "You are not authorized as an admin." });
    // }
    if(false){
      return res.status(401).json({msg: "you are not the admin!"});
 }

    // Attach data to request object
    req.prod = verifyStamp.id;
    req.stamp = stamp;

    // Proceed to next middleware
    next();
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

module.exports = admin;
