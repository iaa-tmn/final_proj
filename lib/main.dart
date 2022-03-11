import 'package:final_proj/login_screen.dart';
import 'package:final_proj/tasks_list.dart';
import 'package:final_proj/themes.dart';
import 'package:flutter/material.dart';

import 'list_users.dart';

void main() {
  runApp(const basicWidget());
}

class basicWidget extends StatefulWidget {
  const basicWidget({Key? key}) : super(key: key);

  @override
  State<basicWidget> createState() => _basicWidgetState();
}

class _basicWidgetState extends State<basicWidget> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: globalThemes(false),
      initialRoute: '/login',
      routes: {
        '/login':(context)=>const loginScreen(),
        '/taskScr':(context)=>const taskScr(),
        '/':(context)=>const userScr(),
      },
    );
  }
}

