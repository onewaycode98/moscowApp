import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/core/models/CRUD_model.dart';
import 'package:todoapp/core/models/task_model.dart';
import 'package:todoapp/ui/views/task_tile.dart';

class TasksList extends StatefulWidget {
  String categoryName;
  TasksList({this.categoryName});

  @override
  _TasksListState createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<CRUDModel>(context);

    return StreamBuilder<QuerySnapshot>(
        stream:
            taskProvider.chooseStream(widget.categoryName, widget.categoryName),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            tasks = snapshot.data.docs
                .map((doc) => Task.fromMap(doc.data(), doc.id))
                .toList();

            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (buildContext, index) => Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Icon(Icons.delete, color: Colors.white)),
                  ),
                ),
                onDismissed: (direction) async {
                  await taskProvider.removeTask(snapshot.data.docs[index].id);
                },
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: TaskTile(
                    taskData: tasks[index],
                    getId: snapshot.data.docs[index].id,
                  ),
                ),
              ),
            );
          } else {
            return Text('fetching');
          }
        });
  }
}
