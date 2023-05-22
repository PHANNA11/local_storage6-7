import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MainBoard extends StatefulWidget {
  const MainBoard({super.key});

  @override
  State<MainBoard> createState() => _MainBoardState();
}

class _MainBoardState extends State<MainBoard> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Database'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Row(
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
                  onPressed: () {},
                  splashColor: Colors.white,
                  child: const Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 40,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 9,
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) => const Card(
                elevation: 0,
                child: ListTile(
                  title: Text('Coca'),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
