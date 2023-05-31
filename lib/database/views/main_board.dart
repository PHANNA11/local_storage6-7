import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:local_storage/database/connection/connection_db.dart';
import 'package:local_storage/database/models/product_model.dart';
import 'package:local_storage/database/views/add_product.dart';
import 'package:local_storage/helper/utility.dart';

class MainBoard extends StatefulWidget {
  const MainBoard({super.key});

  @override
  State<MainBoard> createState() => _MainBoardState();
}

class _MainBoardState extends State<MainBoard> {
  TextEditingController controller = TextEditingController();
  List<ProductModel> listProduct = [];
  ProductModel? tempProduct;
  clearData() {
    tempProduct = null;
    controller.text = '';
  }

  getData() async {
    await ConnectionDB().getProductList().then((value) {
      setState(() {
        listProduct = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Database'),
      ),
      body: Column(
        children: [
          /* Row(
            children: [
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter ProductName'),
                  ),
                ),
              ),
              FloatingActionButton(
                elevation: 0,
                backgroundColor: Colors.white,
                onPressed: () async {
                  if (controller.text.isNotEmpty) {
                    tempProduct == null
                        ? await ConnectionDB()
                            .insertProduct(ProductModel(
                                id: DateTime.now().microsecond,
                                name: controller.text))
                            .whenComplete(() => getData())
                        : await ConnectionDB()
                            .updateProduct(ProductModel(
                                id: tempProduct!.id, name: controller.text))
                            .whenComplete(() => getData());
                  }
                  clearData();
                },
                splashColor: Colors.white,
                child: tempProduct == null
                    ? const Icon(
                        Icons.add,
                        color: Colors.black,
                        size: 40,
                      )
                    : const Icon(
                        Icons.done,
                        color: Colors.green,
                        size: 40,
                      ),
              )
            ],
          ),*/
          Expanded(child: buildGridView())
          // Expanded(
          //   flex: 9,
          //   child: ListView.builder(
          //     itemCount: listProduct.length,
          //     itemBuilder: (context, index) => Slidable(
          //       key: const ValueKey(0),
          //       endActionPane: ActionPane(
          //         motion: const ScrollMotion(),
          //         dismissible: DismissiblePane(onDismissed: () {}),
          //         children: [
          //           SlidableAction(
          //             onPressed: (value) async {
          //               await ConnectionDB()
          //                   .deleteProduct(listProduct[index].id)
          //                   .whenComplete(() => getData());
          //             },
          //             backgroundColor: Color(0xFFFE4A49),
          //             foregroundColor: Colors.white,
          //             icon: Icons.delete,
          //             label: 'Delete',
          //           ),
          //           SlidableAction(
          //             onPressed: (value) {
          //               setState(() {
          //                 tempProduct = listProduct[index];
          //                 controller.text = tempProduct!.name;
          //               });
          //             },
          //             backgroundColor: Color(0xFF21B7CA),
          //             foregroundColor: Colors.white,
          //             icon: Icons.edit,
          //             label: 'Edit',
          //           ),
          //         ],
          //       ),
          //       child: Card(
          //         elevation: 0,
          //         child: ListTile(
          //           title: Text(listProduct[index].name),
          //         ),
          //       ),
          //     ),
          //   ),
          // )
        ],
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton(
            elevation: 0,
            backgroundColor: const Color.fromARGB(255, 237, 199, 199),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddProduct(),
                  ));
            },
            splashColor: Colors.white,
            child: const Icon(
              Icons.add,
              color: Colors.black,
              size: 40,
            )),
      ),
    );
  }

  Widget buildGridView() {
    return GridView.count(
      mainAxisSpacing: 0,
      crossAxisSpacing: 0,
      crossAxisCount: 2,
      childAspectRatio: 14 / 22,
      children: List.generate(
          listProduct.length, (index) => buildItemCard(listProduct[index])),
    );
  }

  Widget buildItemCard(ProductModel pro) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 4, bottom: 4, right: 8),
      child: Column(
        children: [
          Flexible(
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.blue,
                image: DecorationImage(
                    fit: BoxFit.cover, image: FileImage(File(pro.image))),
              ),
              //child: Text(Utility.dataFromBase64String(pro.image).toString()),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  pro.name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text('\$ ${pro.price}',
                    style: TextStyle(fontSize: 18, color: Colors.red)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
