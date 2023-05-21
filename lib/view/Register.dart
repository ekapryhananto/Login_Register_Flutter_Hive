import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hive/hive.dart';
import 'package:login_register/model/user.dart';
import 'package:login_register/view/LoginPage.dart';
import 'package:bcrypt/bcrypt.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: [
              Text(
                "Register",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                  // obscureText: true,
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
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      )),
                    ),
                    onPressed: _register
                    // onPressed: _login,
                    ),
              ),
              // ListView.builder(
              //   itemCount: users.length,
              //   itemBuilder: (context, index) {
              //     User user = users.getAt(index);
              //     return Text(user.username + user.password);
              //   },
              // )
            ],
          ),
        ),
      )),
    ));
  }

  Future<void> _register() async {
    if (_username.text.isNotEmpty && _password.text.isNotEmpty) {
      var users = Hive.box<User>('users');
      final String password_ = BCrypt.hashpw(_password.text, BCrypt.gensalt());
      users.add(User(username: _username.text, password: password_));

      // for (var i = 0; i < users.length; i++) {
      //   User user = users.getAt(i);
      //   if (_username.text == user.username &&
      //       _password.text == user.password) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
      print('Berhasil Register');

      //   } else {
      //     print('GAGAL');
      //   }
      // }
    }
  }
}
