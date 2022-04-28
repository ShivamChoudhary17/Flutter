import 'dart:async';
import 'dart:async';

import 'package:sqflite/sqflite.dart';

import 'listview_model.dart';
const String tableAlarm = 'alarm';
const String columnId = 'id';
const String columnTitle = 'title';
const String columnDateTime = 'alarmDateTime';
const String columnPending = 'isPending';
const String columnColorIndex = 'gradientColorIndex';

class AlarmHelper {
  late Database _database;
  late AlarmHelper _alarmHelper;



  /* If null initialize it if exists return */
  Future<Database> get database async {
    if(_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

/* initializeDatabase */
  Future<Database> initializeDatabase() async {
    var dir = await getDatabasesPath();
    var path = dir + "alarm.db";
    var database =
        await openDatabase(path, version: 1, onCreate: (db, version) {
          db.execute('''
          create table $tableAlarm ( 
          $columnId integer primary key autoincrement, 
          $columnTitle text not null,
          $columnDateTime text not null,
          $columnPending integer,
          $columnColorIndex integer
          ''');
        });

    return database;
  }

  void insertAlarm(AlarmInfo alarmInfo) async {
    var db = await database;
    db.insert(tableAlarm, alarmInfo.toMap());
  }

  Future<List<AlarmInfo>> getAlarm() async {
    List<AlarmInfo> _alarm = [];

    var db = await database;
    var result = await db.query(tableAlarm);
    for (var element in result) {
      var alarmInfo = AlarmInfo.fromMap(element);
      _alarm.add(alarmInfo);
    }
    return _alarm;
  }

  Future<int> delete(int id) async {
    var db = await database;
    return await db.delete(tableAlarm, where: '$columnId = ?', whereArgs: [id]);
  }

}
