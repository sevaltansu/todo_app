import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddTaskAlertDialog extends StatefulWidget {
  @override
  _AddTaskAlertDialogState createState() => _AddTaskAlertDialogState();
}

class _AddTaskAlertDialogState extends State<AddTaskAlertDialog> {
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescController = TextEditingController();
  final List<String> listItem = ['İş', 'Okul', 'Diğer'];
  late String valueChoose = '';
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return AlertDialog(
      title: Text(
        "Yeni Görev",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.grey[800], fontSize: 16),
      ),
      content: SizedBox(
        height: height * 0.35,
        width: width,
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: taskNameController,
                style: TextStyle(fontSize: 14),
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    hintText: "Görev",
                    hintStyle: TextStyle(fontSize: 14),
                    icon: Icon(
                      CupertinoIcons.square_list,
                      color: Colors.grey[700],
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: taskDescController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  hintText: 'Açıklama',
                  hintStyle: TextStyle(fontSize: 14),
                  icon: Icon(CupertinoIcons.bubble_left_bubble_right,
                      color: Colors.grey[700]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Icon(CupertinoIcons.tag, color: Colors.grey[700]),
                  SizedBox(width: 15.0),
                  Expanded(
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 15,
                        ),
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      isExpanded: true,
                      hint: const Text(
                        'Görev Başlığı',
                        style: TextStyle(fontSize: 14),
                      ),

                      // validator: (value) => value == null
                      //     ? 'Please select the task tag' : null,
                      items: listItem
                          .toSet()
                          .map(
                            (item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (String? value) => setState(
                        () {
                          if (value != null) valueChoose = value;
                        },
                      ),
                    ),
                  )
                ],
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
            final taskName = taskNameController.text;
            final taskDesc = taskDescController.text;
            final listItem = valueChoose;
            String selectedListItem =
                valueChoose.isEmpty ? listItem[0] : valueChoose;

            _addTasks(
              taskName: taskName,
              taskDesc: taskDesc,
              listItem: listItem,
            );
            Navigator.of(context, rootNavigator: true).pop();
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.grey[900],
          ),
          child: Text('Kaydet'),
        ),
      ],
    );
  }

  Future _addTasks({
    required String taskName,
    required String taskDesc,
    required String listItem,
  }) async {
    DocumentReference docRef =
        await FirebaseFirestore.instance.collection('tasks').add(
      {
        'taskName': taskName,
        'taskDesc': taskDesc,
        'listItem': listItem,
      },
    );
    String taskId = docRef.id;
    await FirebaseFirestore.instance.collection('tasks').doc(taskId).update(
      {'id': taskId},
    );
    _clearAll();
  }

  void _clearAll() {
    taskNameController.text = '';
    taskDescController.text = '';
  }
}
