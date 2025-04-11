import 'package:amazon_clone/controller/homeController.dart';
import 'package:flutter/material.dart';

import '../model/product.dart';

class TopCategories extends StatefulWidget {
  String category;
  TopCategories({super.key, required this.category});

  @override
  State<TopCategories> createState() => _TopCategoriesState();
}

class _TopCategoriesState extends State<TopCategories> {
  List<Product>? productList;
  final HomeController homeController = HomeController();
  fetchCategoryProd() async{
    productList = await homeController.fetchCategory(context: context, category: widget.category);
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    fetchCategoryProd();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(color: Colors.amberAccent),
            ),
            title: Text(widget.category),
          )),
      body: productList == null? const Scaffold(body: Center(child: CircularProgressIndicator(),),): productList!.isEmpty? Scaffold(
        body: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [const Icon(Icons.close_rounded,size: 140,),const Text('No Items Available'),TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: const Text('Go Back'))],),),)
          :Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20,),
            child: Text("Showing result for ${widget.category}", style: const TextStyle(fontSize: 17, fontWeight: FontWeight
            .w400),),
          ),
          SizedBox(
            height: 670,
            child: GridView.builder(
              itemCount: productList!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemBuilder: (context, index) {
                  return Material(
                    elevation: 3,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 160,
                          child: DecoratedBox(
                            decoration: const BoxDecoration(

                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.network(productList![index].images[0]),
                            ),
                          ),
                        ),
                        Container(alignment: Alignment.topCenter,

                        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                        child: Text(productList![index].name, maxLines: 1, overflow: TextOverflow.ellipsis,textAlign: TextAlign.center, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),),)
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
