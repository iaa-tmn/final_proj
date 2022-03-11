import 'dart:async';
import 'dart:convert';

import 'package:final_proj/arguments.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'User.dart';
import 'Navigation.dart';

class userScr extends StatelessWidget {
  const userScr ({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: globalAppBar(context),
      drawer: navDraw(context),
      body: UsersListScreen(),
    );
  }
}


Future<List<User>> _fetchUsersList() async {
  final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users/"));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((user) => User.fromJson(user)).toList();
  } else {
    throw Exception('Failed to load users from API');
  }
}

ListView _usersListView(data,BuildContext context) {
  return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return _userListTile(data[index], Icons.person_outline, context);
      });
}

ListTile _userListTile(User user, IconData icon,BuildContext context) => ListTile(
  title: Text("${user.id}: ${user.name}",
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 20,
      )),
  subtitle: Text("${user.email}"),
  leading: Icon(
    icon,
    color: Colors.blue[500],
  ),
  onTap: (){
    Navigator.pushNamed(context, '/taskScr',arguments: TaskScreenArguments(user));
  },
);

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({Key? key}) : super(key: key);

  @override
  _UsersListScreenState createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  late Future<List<User>> futureUsersList;
  late List<User> usersListData;

  @override
  void initState() {
    super.initState();
    futureUsersList = _fetchUsersList();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FutureBuilder<List<User>>(
            future: futureUsersList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                usersListData = snapshot.data!;
                return _usersListView(usersListData, context);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return const CircularProgressIndicator();
            })
    );
  }
}

