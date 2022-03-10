import 'dart:async';
import 'dart:convert';

import 'package:final_proj/arguments.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'User.dart';
import 'task.dart';

class taskScr extends StatelessWidget {
  const taskScr ({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as TaskScreenArguments;
    return const Scaffold(
      body: TaskListScreen(args.user),
    );
  }
}


Future<List<Task>> _fetchTaskList(int? id) async {

  final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/todos?userId="+id.toString()));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((task) => Task.fromJSON(task)).toList();
  } else {
    throw Exception('Failed to load users from API');
  }
}

ListView _taskListView(data,BuildContext context) {
  return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return _taskListTile("${data[index].id}: ${data[index].name}", data[index].email, Icons.work, context);
      });
}

ListTile _taskListTile(String title, String subtitle, IconData icon,BuildContext context) => ListTile(
  title: Text(title,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 20,
      )),
  subtitle: Text(subtitle),
  leading: Icon(
    icon,
    color: Colors.blue[500],
  ),
  onTap: (){
    Navigator.pushNamed(context, '/',);
  },
);

class TaskListScreen extends StatefulWidget {

  TaskListScreen(User? this.userI, {Key? key}) : super(key: key);

  User? userI;

  @override
  _TaskListScreenState createState() => _TaskListScreenState(this.userI);
}

class _TaskListScreenState extends State<TaskListScreen> {

  late Future<List<Task>> futureTaskList;
  late List<Task> taskListData;
  User? user;
  _TaskListScreenState(this.user);

  @override
  void initState() {
    super.initState();
    futureTaskList = _fetchTaskList(user!.id);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FutureBuilder<List<Task>>(
            future: futureTaskList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                taskListData = snapshot.data!;
                return _taskListView(taskListData, context);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              return const CircularProgressIndicator();
            })
    );
  }
}

