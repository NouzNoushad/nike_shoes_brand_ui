import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MyDB {
  Database? db;

  Future open() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'myBrands.db');
    print(path);
    db = await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE myBrands (
          id integer primary key autoIncrement,
          image varchar(255) not null,
          name varchar(255) not null,
          price double not null
        )
        ''');
    });
  }
}
