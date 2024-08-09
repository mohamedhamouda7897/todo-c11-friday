import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_c11_friday/firebase_functions.dart';
import 'package:todo_c11_friday/models/task_model.dart';

class TaskItem extends StatelessWidget {
  TaskModel model;

  TaskItem({required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Slidable(
        startActionPane: ActionPane(motion: DrawerMotion(), children: [
          SlidableAction(
            onPressed: (context) {
              FirebaseFunctions.deleteTask(model.id);
            },
            backgroundColor: Colors.red,
            icon: Icons.delete,
            label: "Delete",
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(18), topLeft: Radius.circular(18)),
          ),
          SlidableAction(
            onPressed: (context) {},
            label: "Edit",
            backgroundColor: Colors.blue,
            icon: Icons.edit,
          ),
        ]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                  height: 90,
                  width: 2,
                  color: model.isDone ? Colors.green : Colors.blue),
              SizedBox(
                width: 18,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.title,
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: model.isDone ? Colors.green : Colors.blue),
                    ),
                    Text(
                      model.description,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              model.isDone
                  ? Text(
                      "DONE!!",
                      style: TextStyle(fontSize: 22, color: Colors.green),
                    )
                  : IconButton(
                      onPressed: () {
                        model.isDone = true;
                        FirebaseFunctions.updateTask(model);
                      },
                      padding: EdgeInsets.zero,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: Size(80, 40),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                      icon: Icon(
                        Icons.done,
                        size: 30,
                        color: Colors.white,
                      ))
            ],
          ),
        ),
      ),
    );
  }
}
