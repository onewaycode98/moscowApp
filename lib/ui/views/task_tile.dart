import 'package:flutter/material.dart';
import 'package:todoapp/const.dart';
import 'package:todoapp/core/models/task_model.dart';
import 'package:todoapp/core/models/CRUD_model.dart';
import 'package:provider/provider.dart';

class TaskTile extends StatefulWidget {
  final Task taskData;
  final String getId;
  bool isDone = false;

  TaskTile({@required this.taskData, this.getId});

  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    var taskProvider = Provider.of<CRUDModel>(context);
    return ListTile(
      title: Text(
        widget.taskData.title,
        style: TextStyle(
            decoration: widget.taskData.isDone
                ? TextDecoration.lineThrough
                : TextDecoration.none,
            color: kDarkGrey),
      ),
      leading: Checkbox(
        value: widget.taskData.isDone,
        onChanged: (value) async {
          setState(() {
            widget.taskData.toggleIsDone();
            print(widget.getId);
          });
          await taskProvider.updateTask(
              Task(
                  isDone: widget.taskData.isDone,
                  title: widget.taskData.title,
                  category: widget.taskData.category),
              widget.getId);
        },
      ),
    );
  }
}
