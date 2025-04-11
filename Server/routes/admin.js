const express = require("express");
const admin = require("../middlewares/admin");
const {Product} = require("../model/product");
const adminRouter = express.Router();

adminRouter.post('/admin/add-product',admin,  async(req, res)=>{
     try{
          const {name, description, images, quantity, price, category} = req.body;
          console.log(name);
          let product = new Product({
               name,
               description,
               images,
               quantity,
               price,
               category
          })
          product = await product.save();
          res.json(product);

     }catch(err){
          res.status(500).json({error:err.message});
     }
});

adminRouter.get("/admin/get-products", admin, async (req, res) => {
     try {
          const products = await Product.find({});
          //console.log("Fetched products: ", products);
          res.json(products);
     } catch (err) {
          console.error("Error fetching products: ", err);
          res.status(500).json({ error: err.message });
     }
});

adminRouter.post("/admin/delete-product", admin, async (req, res) => {
     try {
          const {id}= req.body;
          let product =await Product.findByIdAndDelete(id);
          res.json(product);
     } catch (err) {
          console.error("Error fetching products: ", err);
          res.status(500).json({ error: err.message });
     }
});
module.exports = adminRouter;