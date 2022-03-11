import 'package:flutter/material.dart';

AppBar globalAppBar(BuildContext context){
  return AppBar(
    actions: [IconButton(onPressed: (){Navigator.pushNamed(context, '/login');}, icon: Icon(Icons.exit_to_app))],
  );
}

Widget navDraw(context)=> Drawer(
  child: ListView(
    padding: EdgeInsets.zero,
    children: [
      DrawerHeader(
          decoration: const BoxDecoration(color: Colors.blueAccent),
          child: Container(height: 100,child: Image(image: AssetImage("assets/logo_tasks_p.png")),)),
      ListTile(
        leading: Icon(Icons.home),
        title: const Text("Главная"),
        onTap: (){
          Navigator.pushNamed(context, '/');
        },
      ),
      Divider(color: Colors.black12),
      ListTile(
        leading: Icon(Icons.exit_to_app),
        title: const Text("Выход"),
        onTap: (){
          Navigator.pushNamed(context, '/login');
        },
      ),
    ],
  ),
);