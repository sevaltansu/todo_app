import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:todo1_app/utils/colors.dart';

import '../widgets/deleteTask.dart';

class TaskListWidget extends StatefulWidget {
  @override
  State<TaskListWidget> createState() => _State();
}

class _State extends State<TaskListWidget> {
  final fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: StreamBuilder<QuerySnapshot>(
        stream: fireStore.collection('tasks').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text('Error:&{snapshot.error}');
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return Text(
                'No data available'); // Veri yoksa uygun bir mesaj göster
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              Color taskColor = AppColors.blueShadeColor;
              var listItem = data['listItem'];
              if (listItem == 'İş') {
                taskColor = AppColors.salmonColor;
              } else if (listItem == 'Okul') {
                taskColor = Colors.black38;
              }
              return Container(
                height: 100,
                margin: const EdgeInsets.only(bottom: 15.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.shadowColor,
                      blurRadius: 5.0,
                      offset: Offset(0, 5), // shadow direction: bottom right
                    ),
                  ],
                ),
                child: ListTile(
                  leading: Container(
                    width: 20,
                    height: 20,
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      backgroundColor: taskColor,
                    ),
                  ),
                  title: Text(data['taskName']),
                  subtitle: Text(data['taskDesc']),
                  trailing: GestureDetector(
                    onTap: () {
                      String taskId = (data['id'] ?? '');
                      String taskName = (data['taskName'] ?? '');
                      Future.delayed(
                        Duration(seconds: 0),
                        () => showDialog(
                          context: context,
                          builder: (context) => DeleteTaskDialog(
                              taskId: taskId, taskName: taskName),
                        ),
                      );
                    },
                    child: Icon(CupertinoIcons.delete_solid),
                  ),
                  dense: true,
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
