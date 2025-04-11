import 'dart:io';

import 'package:amazon_clone/seller_view/controller/AdminController.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProductScreen extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productDescriptionController =
  TextEditingController();
  final TextEditingController productPriceController = TextEditingController();
  final TextEditingController productQuantityController =
  TextEditingController();

  String category = 'Computer';
  List<String> productCat = [
    'Mobiles',
    'Clothes',
    'Computer',
    'Beauty',
    'Audio',
    'Toys',
    'Appliances'
  ];

  final List<File> _images = [];
bool isUploading  = false;
  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _images.add(File(pickedFile.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
            title: const Text(
              "Add Product",
              style: TextStyle(color: Colors.black),
            ),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                color: Colors.blueAccent,
              ),
            )),
      ),
      body: SingleChildScrollView(
        child: isUploading? const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 250,),
            Center(child: CircularProgressIndicator(strokeWidth: 8),),
            SizedBox(height: 20,),
            Text("Uploading Your Peoduct To\nAmazon Clone App\nPlease wait for while.",textAlign: TextAlign.center,)
          ],
        )
            :Form(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                children: [
                  _images.isEmpty
                      ? GestureDetector(
                    onTap: _getImage,
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(10),
                      dashPattern: const [10, 4],
                      strokeCap: StrokeCap.round,
                      child: Container(
                        width: double.infinity,
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.folder_open,
                              size: 40,
                            ),
                            const SizedBox(height: 15),
                            Text(
                              'Select Product Images',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey.shade400,
                              ),
                            ),
                            Text(
                              'You can select upto 6 images',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey.shade400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                      : SizedBox(
                    height: 300,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _images.length + 1,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0,
                      ),
                      itemBuilder: (context, index) {
                        if (index == _images.length) {
                          if (_images.length == 6) {
                            return const SizedBox();
                          } else {
                            return GestureDetector(
                              onTap: _getImage,
                              child: Container(
                                color: Colors.grey[200],
                                child: const Icon(Icons.add),
                              ),
                            );
                          }
                        } else {
                          return GestureDetector(
                            onTap: () {
                              _viewImageInDialog(_images[index], index);
                            },
                            child: Stack(
                              children: [
                                Hero(
                                  tag: 'imageHero$index',
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: double.infinity,
                                    child: Image.file(
                                      _images[index],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _images.remove(_images[index]);
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(20.0),
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.close,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: productNameController,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a product name.';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      hintText: "Product Name",
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: productDescriptionController,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a product description.';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      hintText: "Product Description",
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: productPriceController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a product price.';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      hintText: "Product Price (in Rs.)",
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: productQuantityController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a product price.';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      hintText: "Product Quantity",
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: DropdownButton(
                        value: category,
                        items: productCat.map((String item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (String? newVal) {
                          setState(() {
                            category = newVal!;
                          });
                        }),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  InkWell(
                      onTap: () {
                        setState(() {
                          isUploading= true;
                        });
                        AdminController().sellProduct
                          (
                          context: context,
                          name: productNameController.text,
                          description: productDescriptionController.text,
                          price: double.parse(productPriceController.text),
                          quantity: int.parse(productQuantityController.text),
                          category: category,
                          images: _images,

                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width / 2 - 70,
                            vertical: 20),
                        decoration: BoxDecoration(color: Colors.amberAccent,
                        borderRadius: BorderRadius.circular(15.0)),
                        child: const Text("Add Product"),
                      )),
                ],
              ),
            )),
      ),
    );
  }

  void _viewImageInDialog(File imageFile, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Hero(
                tag: 'imageHero$index',
                child: Image.file(
                  imageFile,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}