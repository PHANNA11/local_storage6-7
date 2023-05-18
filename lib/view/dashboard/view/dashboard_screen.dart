import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:local_storage/view/auth/signin_acc_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  TextEditingController nameController = TextEditingController();
  List<String> usersList = [];
  getListUser() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      usersList = prefs.getStringList('user') ?? ['Kanha', 'dalin', 'Chivorn'];
    });
  }

  setListUser(dynamic listUsers) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('user', listUsers);
  }

  @override
  void initState() {
    // TODO: implement initState
    getListUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Theme.of(context).primaryColor,
        child: SafeArea(
            child: Column(
          children: [
            Card(
              elevation: 0,
              child: ListTile(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignInScreen(),
                      ),
                      (route) => false);
                },
                title: const Text('Sign Out'),
                leading: const Icon(
                  Icons.person,
                  size: 30,
                ),
              ),
            )
          ],
        )),
      ),
      appBar: AppBar(
        title: const Text('Welcome to App'),
      ),
      body: Column(children: [
        Expanded(
          flex: 1,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Enter name'),
              ),
            ),
            CupertinoButton(
                color: Theme.of(context).primaryColor,
                child: const Text('Add'),
                onPressed: () {
                  if (nameController.text.isNotEmpty) {
                    getListUser();
                    usersList.add(nameController.text);
                    setListUser(usersList);
                    setState(() {
                      getListUser();
                    });
                  }
                })
          ]),
        ),
        Expanded(
          flex: 3,
          child: ListView.builder(
            itemCount: usersList.length,
            itemBuilder: (context, index) => Card(
                elevation: 0,
                child: ListTile(
                  title: Text(usersList[index]),
                )),
          ),
        )
      ]),
    );
  }
}
