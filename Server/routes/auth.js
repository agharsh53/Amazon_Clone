const express = require("express");
const bcryptjs = require('bcryptjs');
const User = require('../model/user');
const jwt = require('jsonwebtoken');
const auth =  require('../middlewares/auth');
const user = require("../model/user");
const authRouter = express.Router();
//mongodb+srv://agharsh53:<db_password>@cluster0.1jbrx.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0

//validation
authRouter.post("/api/signup",async (req, res)=>{


try{
//receive data from user
const {name, email,password} = req.body;

//req.body- Map Type - {name="adad", email= "adad@faf.ada", password="adad"}
const exist = await User.findOne({email});
if(exist){
return res.status(400).json({msg:"User already exist."});}


const hashedPassword = await bcryptjs.hash(password,10);
//upload that data to db
let user = new User({
email,
password :hashedPassword,
name
});
user = await user.save();
res.json(user);

}catch(er){
     res.status(500).json({errror:er.message});
}

});


authRouter.post("/validateStamp", async (req, res)=>{
    try{
        const stamp = req.header('stamp');
    if(!stamp){
        return res.json(false);
    }
    const isValid = jwt.verify(stamp,"secretKey");
    if(!isValid) return res.json(false);
    const user = await User.findById(isValid.id);
    if(!user) return res.json(false);
    res.json(true);
    }catch(e){
    res.status(500).json({error:e.message});
}
    
})

authRouter.post("/api/signin", async(req,res)=>{
try{
const {email,password} = req.body;
const exist = await User.findOne({email});

if(!exist){
return res.status(400).json({msg:"User doesn't exist."});
}

if (!exist.password) {
    return res.status(400).json({ msg: "User does not have a password set." });
}
const isMatching = await bcryptjs.compare(password,exist.password);
if(!isMatching){
return res.status(400).json({msg:"Incorrect Password"});
}

//JSON Webtoken

//Token creation
//Token Transmission
//Token Usage
//Token Verification
//Token Control

// 
// 
// //{
//     "name" : "Dhruv",
//     "email" : "dddddd@gmail.com",
//     ....
// } 

// res.json({token , ...user._doc});

// //{
    // "token" : "qur82uro_fq8qiwhieogg"
//     "name" : "Dhruv",
//     "email" : "dddddd@gmail.com",
//     ....
// } 

const stamp = jwt.sign({id:exist._id},"secretKey");
res.json({stamp, ...exist._doc});


}catch(er){
res.status(500).json({error:er.message});
}})

authRouter.get('/',auth, async(req, res)=>{
     const user = await User.findById(req.user);
     
     res.json({...user._doc, stamp : req.stamp});
 });



module.exports = authRouter;