import 'package:amazon_clone/model/product.dart';
import 'package:amazon_clone/seller_view/addProduct.dart';
import 'package:amazon_clone/seller_view/controller/AdminController.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<Product> products = [];
  final AdminController adminController = AdminController();

  fetchAllProducts() async {
    products = await adminController.fetchAllProducts(context);
    setState(() {});
  }

  void deleteProduct(Product delProduct, int index) {
    adminController.deleteProduct(
        context: context,
        product: delProduct,
        onSuccess: () {
          products.removeAt(index);
          setState(() {});
        });
  }

  @override
  void initState() {
    super.initState();
    fetchAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return products.isEmpty
        ? const Scaffold(

            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
      appBar: AppBar(title: const Text("Your Products"),backgroundColor: Theme.of(context).primaryColorDark,),
            floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () {
                  Navigator.pushNamed(context, AddProductScreen.routeName);
                }),
            body: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text('Showing Total ${products.length} products',style: const TextStyle(fontSize: 15),textAlign: TextAlign.left),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                Expanded(
                  child: GridView.builder(
                      itemCount: products.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 5),
                      itemBuilder: (context, index) {
                        final product = products[index];
                        return Container(
                          decoration: BoxDecoration(
                  
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Material(
                              elevation: 3,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      height: 150,
                                      child: Image.network(product.images[0], fit: BoxFit.contain,)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          child: Text(
                                        product.name,style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                                        textAlign: TextAlign.left,
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 10.0),
                                        child: InkWell(
                                            onTap: () {
                                              deleteProduct(product, index);
                                              print("Deleting Product");
                                            },
                                            child: const Icon(Icons.delete)),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          );
  }
}
