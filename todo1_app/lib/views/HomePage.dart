import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo1_app/views/tasks.dart';
import 'categoriesPage.dart';
import '../widgets/AddTaskPage.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        backgroundColor: Colors.grey,
        centerTitle: true,
        title: Text("Yapılacaklar Listesi"),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.calendar))
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[700],
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => AddTaskAlertDialog(),
            ),
          );
          // Floating action buttona tıklandığında yapılacak işlemler
        },
        child: Icon(Icons.add), // Artı işaretli ikon
        elevation: 2.0,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey,
        shape: CircularNotchedRectangle(),
        notchMargin: 5.0,
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          height: kBottomNavigationBarHeight,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  color: Colors.white,
                  onPressed: () {
                    setState(() {});
                  },
                  icon: Icon(Icons.list_alt)),
              IconButton(
                  color: Colors.white,
                  onPressed: () {
                    setState(() {});
                  },
                  icon: Icon(CupertinoIcons.tag)),
            ],
          ),
        ),
      ),
      body: TaskListWidget(),
    );
  }
}
