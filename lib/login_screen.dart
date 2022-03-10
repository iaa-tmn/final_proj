import 'package:final_proj/themes.dart';
import 'package:flutter/material.dart';

import 'login.dart';

var _login='';
var _pass='';
class loginScreen extends StatelessWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const Image(image: AssetImage("assets/logo_tasks_p.png")),
                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: TextField(
                      onChanged: (String value) {_login=value;},
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "Телефон",
                        filled: true,
                        enabledBorder:borderStyle(),
                        focusedBorder:focusedBorderStyle(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: TextField(
                      onChanged: (String value) {_pass=value;},
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Пароль",
                        filled: true,
                        enabledBorder:borderStyle(),
                        focusedBorder:focusedBorderStyle(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  SizedBox(
                      width: 120, height: 40,
                      child: ElevatedButton(
                      onPressed: () {
                        bool valid=validateUserPass(_login,_pass);
                        final snackBar =SnackBar(content: Text("Не верный логин или пароль"));
                        if (valid==true){
                          Navigator.pushNamed(context, '/',);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        };


                      },
                      child: Text("Войти"))
                  )
                ],
              ),
            ),
          ),
        ),
      );
  }
}
