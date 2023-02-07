import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite_test/database/local_main_database.dart';
import 'package:sqflite_test/home.dart';

class AddNotes extends StatelessWidget {
  AddNotes({Key? key}) : super(key: key);

  MyDatabase db=MyDatabase();

  GlobalKey formstate = GlobalKey();
  TextEditingController titleController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Notes"),
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          children: [
            Form(
              key: formstate,
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: "title",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: notesController,
                    decoration: const InputDecoration(
                      labelText: "notes",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                 db.insertData(
                  '''
                  INSERT INTO 'notes' ('note','title') VALUES ("${notesController.text}","${titleController.text}")
                  '''
                );

                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return HomePage();
                }));

              },
              child: Text(
                "Add Notes",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
