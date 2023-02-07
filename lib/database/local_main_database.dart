import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MyDatabase{
  static Database? _db;

  Future<Database?> get db async{
    if(_db == null){
      _db = await initialDatabase();
      return _db;
    }else {
      return _db;
    }
  }

   initialDatabase() async{
    String inipath = await getDatabasesPath();
    String path = join(inipath,'mohamed.db');
    Database MyDB =await openDatabase(path,onCreate: _oncreate ,version: 2,onUpgrade: _onupgrade);
    return MyDB;
   }

  _onupgrade(Database mydb,int oldversion,int newversion) async {

    await mydb.execute('''
    ALTER TABLE notes ADD COLUMN title TEXT
    ''');
  }

  _oncreate(Database mydb,int version)async{
    await mydb.execute(
      '''
      CREATE TABLE 'notes'(
      'id' INTEGER PRIMARY KEY NOT NULL,
      'note' TEXT NOT NULL
      ) 
      ''');
  }

  readData(String sql)async {
      Database? read =await db;
      List<Map> response =await read!.rawQuery(sql);
      return response;
  }

  insertData(String sql)async {
    Database? read =await db;
    int response =await read!.rawInsert(sql);
    return response;
  }

  updateData(String sql)async {
    Database? read =await db;
    int response =await read!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql)async {
    Database? read =await db;
    int response =await read!.rawDelete(sql);
    return response;
  }



  Deletedatabase()async{
    String inipath = await getDatabasesPath();
    String path = join(inipath,'mohamed.db');
    await deleteDatabase(path);
  }

}