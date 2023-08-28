import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DeleteTaskDialog extends StatefulWidget {
  final String taskId, taskName;

  DeleteTaskDialog({required this.taskId, required this.taskName});

  @override
  State<DeleteTaskDialog> createState() => _DeleteTaskDialogState();
}

class _DeleteTaskDialogState extends State<DeleteTaskDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text(
        'Görevi Sil',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black87, fontSize: 16),
      ),
      content: SizedBox(
        child: Form(
          child: Column(
            children: [
              Text(
                'Bu görevi silmek istediğine emin misin?',
                style: TextStyle(color: Colors.black87, fontSize: 14),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                widget.taskName.toString(),
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.grey,
          ),
          child: Text('Vazgeç'),
        ),
        ElevatedButton(
            onPressed: () {
              _deleteTasks(widget.taskName, widget.taskId);
              Navigator.of(context, rootNavigator: true).pop();
            },
            style: ElevatedButton.styleFrom(primary: Colors.grey[900]),
            child: Text('Sil'))
      ],
    );
  }

  Future _deleteTasks(String taskName, String taskId) async {
    var collection = FirebaseFirestore.instance.collection('tasks');
    collection
        .doc(widget.taskId)
        .delete()
        .then(
          (_) => Fluttertoast.showToast(
              msg: "Görev Silindi!",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.SNACKBAR,
              backgroundColor: Colors.black54,
              textColor: Colors.white,
              fontSize: 14.0),
        )
        .catchError(
          (error) => Fluttertoast.showToast(
              msg: "Hata: $error",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.SNACKBAR,
              backgroundColor: Colors.black54,
              textColor: Colors.white,
              fontSize: 14.0),
        );
  }
}
