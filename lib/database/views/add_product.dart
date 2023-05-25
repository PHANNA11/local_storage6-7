import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: nameController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Enter product name'),
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
                const SizedBox(
                  height: 250,
                  width: double.infinity,
                  child: Image(
                    image: AssetImage('assets/image/no_image.jpg'),
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
                onPressed: () {}),
          )
        ],
      ),
    );
  }

  void selectImage() async {
    await ImagePicker().pickImage(source: ImageSource.gallery);
  }

  void takeImage() async {
    await ImagePicker().pickImage(source: ImageSource.camera);
  }
}
