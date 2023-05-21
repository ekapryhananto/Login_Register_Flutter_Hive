import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hive/hive.dart';
import 'package:login_register/model/user.dart';
import 'package:login_register/view/Home.dart';
import 'package:login_register/view/Register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();

  late Box box1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: Hive.openBox<User>("users"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text('error'),
            );
          } else {
            var users = Hive.box<User>('users');
            if (users.length == 0) {
              users.add(User(username: 'Ergyna', password: '123'));
            }
            return SingleChildScrollView(
              child: SafeArea(
                  child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(50),
                  child: Column(
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      TextField(
                          controller: _username,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person_outline,
                              size: 20,
                            ),
                            hintText: 'Username',
                            contentPadding:
                                const EdgeInsets.only(bottom: 8.0, top: 8.0),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                          )),
                      TextField(
                          obscureText: true,
                          controller: _password,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              size: 20,
                            ),
                            hintText: 'Password',
                            contentPadding:
                                const EdgeInsets.only(bottom: 8.0, top: 8.0),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: TextButton(
                            child: Text(
                              "Masuk".toUpperCase(),
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.all(10)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color(0xffF3AB0D)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              )),
                            ),
                            onPressed: _login
                            // onPressed: _login,
                            ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: TextButton(
                            child: Text(
                              "REGISTER".toUpperCase(),
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  EdgeInsets.all(10)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromARGB(255, 13, 243, 205)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              )),
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterPage()));
                            }
                            // onPressed: _login,
                            ),
                      ),
                    ],
                  ),
                ),
              )),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));
  }

  Future<void> _login() async {
    if (_username.text.isNotEmpty && _password.text.isNotEmpty) {
      var users = Hive.box<User>('users');
      for (var i = 0; i < users.length; i++) {
        users.getAt(i);
        if (_username.text == users.getAt(i)!.username &&
            _password.text == users.getAt(i)!.password) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        }
        // else {
        //   print('GAGAL');
        // }
      }
    }
  }
}
