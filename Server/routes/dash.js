const express = require('express');

const dash = express.Router();

dash.get("/dashboard", (req, res)=>{
res.json({data: "500k"})
})

module.exports = dash;