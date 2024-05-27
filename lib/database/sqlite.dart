import 'dart:ffi';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
// 定义一个异步函数来获取数据库路径
Future<String> getDatabasePath(String dbName) async {
  // 获取应用的文档目录
  final directory = await getApplicationDocumentsDirectory();
  // 拼接路径
  final path = join(directory.path, dbName);
  print('$path');
  return path;
}
class MoneyItem {
  String type;
  num money;
  String date;
  MoneyItem(this.type,this.money,this.date);
  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'money': money,
      'date': date
    };
  }
}
class SendItem extends MoneyItem{
  num id;
  SendItem(String type,num money,String date,this.id) : super(type, money, date);
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'money': money,
      'date': date
    };
  }
}
Future<Database> createDatabase() async {
  // 获取数据库路径
  final path = await getDatabasePath('bookkeeing.db');
  // 打开数据库
  final database = openDatabase(
    path,
    version: 1,
    // 当数据库第一次被创建时，执行创建表的操作
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE sendList(id INTEGER PRIMARY KEY, type TEXT,money INTEGER,date TEXT)",
      );
    },
  );
  return database;
}
//插入数据
Future<void> insertData(MoneyItem data, Database db) async {
  try {
    // 插入数据到数据库
    await db.insert(
      'sendList',
      data.toMap(),
      // 如果插入的数据与已有数据冲突（例如，两个数据有相同的主键），则替换旧数据
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  } catch (e) {
    // 打印错误信息
    print('Failed to insert data: $e');
  }
}
Future<List<SendItem>> queryAll(Database db) async {
  // 查询所有数据
  final List<Map<String, dynamic>> maps = await db.query('sendList');
  return List.generate(maps.length, (i) {
    return SendItem(
      maps[i]['type'],
      maps[i]['money'],
      maps[i]['date'],
      maps[i]['id'],
    );
  });
}

