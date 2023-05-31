import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_storage/database/connection/connection_db.dart';
import 'package:local_storage/database/models/product_model.dart';

import '../../helper/utility.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  File? imgString;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter product name'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: priceController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter product price'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  imgString == null
                      ? const SizedBox(
                          height: 250,
                          width: double.infinity,
                          child: Image(
                              image: AssetImage('assets/image/no_image.jpg')))
                      : SizedBox(
                          height: 250,
                          width: double.infinity,
                          // child: Text(
                          //     Utility.dataFromBase64String(imgString.toString())
                          //         .toString()),
                          child: Image(
                            image: FileImage(File(imgString!.path)),
                          ),
                        ),
                  Positioned(
                      bottom: 0,
                      right: 50,
                      child: Container(
                        height: 70,
                        width: 70,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 248, 230, 230)),
                        child: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  alignment: Alignment.bottomCenter,
                                  title: Text('Select Image'),
                                  content:
                                      Text('Please choose one for get image'),
                                  actions: [
                                    ListTile(
                                      onTap: () async {
                                        selectImage();
                                      },
                                      leading: Icon(Icons.image),
                                      title: Text('Gallery'),
                                    ),
                                    ListTile(
                                      onTap: () async {
                                        takeImage();
                                      },
                                      leading: Icon(Icons.camera_alt),
                                      title: Text('Camera'),
                                    )
                                  ],
                                );
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.camera_alt_outlined,
                            size: 40,
                          ),
                        ),
                      ))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoButton(
                  color: Theme.of(context).primaryColor,
                  child: const Text('save'),
                  onPressed: () async {
                    ConnectionDB().insertProduct(ProductModel(
                        id: DateTime.now().microsecondsSinceEpoch,
                        name: nameController.text,
                        price: double.parse(priceController.text),
                        image: imgString!.path));
                  }),
            )
          ],
        ),
      ),
    );
  }

  void selectImage() async {
    var img = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 100);
    setState(() {
      imgString = File(img!.path);
      log(imgString.toString());
    });
  }

  void takeImage() async {
    var img = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      imgString = File(img!.path);
      log(imgString.toString());
    });
  }
}
