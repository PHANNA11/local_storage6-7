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
      body: buildGridView(),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton(
            elevation: 0,
            backgroundColor: const Color.fromARGB(255, 237, 199, 199),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddProduct(
                      pro: null,
                    ),
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
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProduct(pro: pro),
            ));
      },
      onLongPress: () async {
        await ConnectionDB().deleteProduct(pro.id).whenComplete(() {
          setState(() {
            getData();
          });
        });
      },
      child: Padding(
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
      ),
    );
  }
}
