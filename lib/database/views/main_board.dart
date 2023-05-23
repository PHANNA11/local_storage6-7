import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:local_storage/database/connection/connection_db.dart';
import 'package:local_storage/database/models/product_model.dart';

class MainBoard extends StatefulWidget {
  const MainBoard({super.key});

  @override
  State<MainBoard> createState() => _MainBoardState();
}

class _MainBoardState extends State<MainBoard> {
  TextEditingController controller = TextEditingController();
  List<ProductModel> listProduct = [];
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
          Row(
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
                  await ConnectionDB()
                      .insertProduct(ProductModel(
                          id: DateTime.now().microsecond,
                          name: controller.text))
                      .whenComplete(() => getData());
                },
                splashColor: Colors.white,
                child: const Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 40,
                ),
              )
            ],
          ),
          Expanded(
            flex: 9,
            child: ListView.builder(
              itemCount: listProduct.length,
              itemBuilder: (context, index) => Slidable(
                key: const ValueKey(0),
                endActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  dismissible: DismissiblePane(onDismissed: () {}),
                  children: [
                    SlidableAction(
                      onPressed: (value) async {
                        await ConnectionDB()
                            .deleteProduct(listProduct[index].id)
                            .whenComplete(() => getData());
                      },
                      backgroundColor: Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                    SlidableAction(
                      onPressed: (value) {},
                      backgroundColor: Color(0xFF21B7CA),
                      foregroundColor: Colors.white,
                      icon: Icons.edit,
                      label: 'Edit',
                    ),
                  ],
                ),
                child: Card(
                  elevation: 0,
                  child: ListTile(
                    title: Text(listProduct[index].name),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
