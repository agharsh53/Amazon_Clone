console.log("hello kaise ho bhai log!");

const express = require('express'); // import '......material.dart
const mongoose = require('mongoose');
const dash = require("./routes/dash");
const auth = require("./routes/auth");
const adminRouter = require("./routes/admin");
const productRouter = require("./routes/products");
const userRouter = require("./routes/user");
const DB = "mongodb+srv://agharsh53:M%40h%40dev07ji%24@cluster0.1jbrx.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0"

//M%40h%40dev07ji%24
const app = express(); // dataModel = DataModel();
const PORT = 3000;

// app.get("/",  (req, res)=> {
//      res.send("Home Page")
// });

app.use(dash);
app.use(express.json());
app.use(auth);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);

//Client <--middleware> Server
mongoose.connect(DB).then(() => {
     console.log("Connection Succesfully");
}).catch((e) => {   
     console.log(e);
});

//PROMISE ASYNCHRONOUS

app.get("/nodemon", function (req, res) {
     console.log("Run NodeMon Website");
     res.send("NodeMon Website");
})

//0.0.0.0--Anywhere

app.listen(PORT, "0.0.0.0", function () {
     console.log("Node.js Server Started.....");
})


