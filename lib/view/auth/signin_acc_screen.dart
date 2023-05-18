import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:local_storage/view/auth/signup_acc_screen.dart';
import 'package:local_storage/view/dashboard/view/dashboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  String? email, password;
  getUser() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email') ?? 'admin';
      password = prefs.getString('password') ?? 'admin';
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Image.network(
                  'https://images.velog.io/images/woounnan/post/d8da8332-3113-4c25-ae6e-be1e8a1dd38c/logo-SYSTEM.png'),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                    hintText: 'Enter email'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: passController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                    hintText: 'Enter password'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            ));
                      },
                      child: const Text('Register')),
                )
              ],
            ),
            CupertinoButton(
                color: Theme.of(context).primaryColor,
                onPressed: () async {
                  if (emailController.text.isNotEmpty &&
                      passController.text.isNotEmpty) {
                    if (email == emailController.text &&
                        password == passController.text) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DashBoardScreen(),
                          ),
                          (route) => false);
                    } else {
                      final snackBar = SnackBar(
                        content: const Text('please check your account'),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {
                            // Some code to undo the change.
                          },
                        ),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  } else {
                    final snackBar = SnackBar(
                      content: const Text('Please enter data....!!!'),
                      action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () {
                          // Some code to undo the change.
                        },
                      ),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: const Text('Sign In'))
          ],
        ),
      ),
    );
  }
}
