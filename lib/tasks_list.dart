import 'dart:async';
import 'dart:convert';

import 'package:final_proj/Navigation.dart';
import 'package:final_proj/arguments.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'User.dart';
import 'task.dart';

class taskScr extends StatelessWidget {
  const taskScr ({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final TaskScreenArguments args = ModalRoute.of(context)!.settings.arguments as TaskScreenArguments;
    final User? user=args.user;
    return Scaffold(
      appBar: globalAppBar(context),
      drawer: navDraw(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: TaskListScreen(user)
        ),
      ),
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
        return _taskListTile(data[index]);
      });
}

class _taskListTile extends StatefulWidget {
  const _taskListTile(Task? this.taskI,{Key? key}) : super(key: key);
  final Task? taskI;
  @override
  State<_taskListTile> createState() => _taskListTileState(taskI);
}

class _taskListTileState extends State<_taskListTile> {
  Task? task;
  _taskListTileState(this.task);
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text("${task!.title}", style: Theme.of(context).textTheme.headline3,),
      value: task!.completed,
      onChanged: (value){setState(() {
        task!.completed=value;

      });},
    );
  }
}

class TaskListScreen extends StatefulWidget {

  const TaskListScreen(User? this.userI, {Key? key}) : super(key: key);

  final User? userI;

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
        child: Column(
          children: [

            Expanded(flex: 1,child: SizedBox(width:double.infinity,height:double.infinity,child: Card(child: userCard(),))),
            Expanded(
              flex: 4,
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
                  }),
            ),
          ],
        )
    );
  }
}

