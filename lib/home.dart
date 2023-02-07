import 'package:flutter/material.dart';
import 'package:sqflite_test/addnotes.dart';
import 'package:sqflite_test/database/local_main_database.dart';
import 'package:sqflite_test/editnote.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MyDatabase data = MyDatabase();

  Future readData() async {
    List<Map> response = await data.readData('''
      SELECT * FROM notes
      ''');
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("home"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return AddNotes();
          }));
        },
        child: Icon(Icons.add),
      ),
      body: ListView(
        children: [
          // ElevatedButton(
          //   onPressed: () async{
          //    await data.Deletedatabase();
          //   },
          //   child: Text(
          //     "delete all data",
          //   ),
          // ),
          //
          // ElevatedButton(
          //   onPressed: () async{
          //     var response =await data.readData(
          //         '''
          //       SELECT * FROM 'notes'
          //       '''
          //     );
          //     print(response);
          //   },
          //   child: Text(
          //     "show data",
          //   ),
          // ),
          // ElevatedButton(
          //   onPressed: () async{
          //     var response =await data.insertData(
          //         '''
          //       INSERT INTO 'notes' ('note') VALUES ('note one')
          //       '''
          //     );
          //     print(response);
          //   },
          //   child: Text(
          //     "insert data",
          //   ),
          // ),
          FutureBuilder(
              future: readData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, i) {
                        return Dismissible(
                          key: UniqueKey(),
                          onDismissed: (d) async {
                            await data.deleteData('''
                              DELETE FROM notes WHERE id = ${snapshot.data[i]['id']}
                              ''');
                          },
                          child: Card(
                            child: ListTile(
                                title: Text("${snapshot.data![i]['title']}"),
                                subtitle: Text("${snapshot.data![i]['note']}"),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return EditNotes(
                                            id: snapshot.data[i]['id'],
                                            title: snapshot.data[i]['title'],
                                            note: snapshot.data[i]['note'],
                                          );
                                        }));
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () async {
                                        await data.deleteData('''
                                  DELETE FROM notes WHERE id = ${snapshot.data[i]['id']}
                                  ''');
                                        setState(() {});
                                      },
                                    ),
                                  ],
                                )),
                          ),
                        );
                      });
                }
                // else if(snapshot.connectionState == ConnectionState.waiting){
                return Center(
                  child: CircularProgressIndicator(),
                );
                //}
              }),
        ],
      ),
    );
  }
}
