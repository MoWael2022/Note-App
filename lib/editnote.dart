import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite_test/database/local_main_database.dart';
import 'package:sqflite_test/home.dart';

class EditNotes extends StatefulWidget {
  final id ,title ,note;
  EditNotes({Key? key, this.id, this.title, this.note}) : super(key: key);

  @override
  State<EditNotes> createState() => _EditNotesState();
}

class _EditNotesState extends State<EditNotes> {
  MyDatabase db=MyDatabase();

  GlobalKey formstate = GlobalKey();

  TextEditingController titleController = TextEditingController();

  TextEditingController notesController = TextEditingController();

  @override
  void initState() {
    print(widget.title);
    print(widget.note);
    titleController.text=widget.title;
    notesController.text=widget.note;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Notes"),
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
                await db.updateData(
                  '''
                  UPDATE notes SET
                  note = "${notesController.text}",
                  title = "${titleController.text}"
                  WHERE id = ${widget.id}
                  '''
                );
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return HomePage();
                }));

              },
              child: const Text(
                "Edit Notes",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
