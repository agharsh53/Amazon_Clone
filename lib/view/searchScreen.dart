
import 'package:amazon_clone/controller/searchController.dart';
import 'package:amazon_clone/model/product.dart';
import 'package:amazon_clone/view/productDetail.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget{
  const SearchScreen({super.key, required this.searchQuery});

  static const String routeName = ".search-screen";
  final String searchQuery;

  @override
  State<SearchScreen> createState() {
    return _SearchScreenState();
  }
}

class _SearchScreenState extends State<SearchScreen>{
  List<Product>? products;
  final SearchControllerServices searchController = SearchControllerServices();
  fetchSeachedProduct()async{
    products = await searchController.fetchSearchedProduct(context:context,searchQuery:widget.searchQuery);
    print(products);
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchSeachedProduct();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 42,
                  margin: const EdgeInsets.only(left: 15),
                  child: Material(
                    borderRadius: BorderRadius.circular(7),
                    elevation: 1,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.search,
                      onFieldSubmitted: (value){
                        Navigator.pushNamed(context, SearchScreen.routeName, arguments: value);
                      },
                      decoration: InputDecoration(
                        prefixIcon: InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.only(
                              left: 6,
                            ),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
                        ),
                        hintText: 'Search Amazon.in',
                        hintStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                      initialValue: widget.searchQuery,
                    ),
                  ),
                ),
              ),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(Icons.mic, color: Colors.black, size: 25),
              ),
            ],
          ),
        ),
      ),
      body: products == null? const Center(child: CircularProgressIndicator(),) : Column(
        children: [
          const SizedBox(height: 10,),
          Expanded(child: ListView.separated( separatorBuilder: (context,index){return const Divider();}, itemCount: products!.length,itemBuilder: (context, index){
            final product = products![index];
            return GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, ProductDetailScreen.routeName,arguments: product);
              },
              child: Column(children: [
                Container(margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(children: [Image.network(product.images[0], height: 120, width: 135,fit: BoxFit.contain,),
                Column(
                  children: [
                    Container(width: 235,padding: const EdgeInsets.symmetric(horizontal: 20),child: Text(product.name, style: const TextStyle(fontSize: 16),maxLines: 2,)),
                    Container(width: 235,padding: const EdgeInsets.only(left: 20,top: 5),child: const RatingStars(value: 3.5,starColor: Colors.redAccent,),),
                    Container(width: 235,padding: const EdgeInsets.only(left: 20,top: 5),child: Text('Rs.${product.price.toString()}',style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),maxLines: 2,)),
                    Container(width: 235,padding: const EdgeInsets.only(left: 20,top: 5),child: const Text('Free Shipping')),
                    Container(width: 235,padding: const EdgeInsets.only(left: 20,top: 5),child: const Text('In Stock',style: TextStyle(fontSize: 16,color: Colors.teal),maxLines: 2,)),
                  ],
                )],),)
              ],),
            );
          }))
        ],
      )
    );
  }
}