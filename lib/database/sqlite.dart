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
  return path;
}
class MoneyItem {
  String type;
  num money;
  int date;
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
  SendItem(String type,num money,int date,this.id) : super(type, money, date);
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
        "CREATE TABLE sendList(id INTEGER PRIMARY KEY, type TEXT,money INTEGER,date INTEGER)",
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
Future<int> getThisMounthBySend(Database db,String type) async {
  try {
    // 查询所有数据
    DateTime now = DateTime.now(); // 获取当前日期时间
    int monthStart = DateTime(now.year, now.month, 1).millisecondsSinceEpoch; // 获取本月第一天的日期时间
    int monthEnd = DateTime(now.year, now.month + 1, 0, 23, 59, 59).millisecondsSinceEpoch; // 获取本月最后一天的日期时间（时间为23:59:59）
    List<Map<String, Object?>> sum = await db.rawQuery('SELECT SUM(money) FROM sendList WHERE date < ${monthEnd} AND date > ${monthStart}  AND type = "${type}";') ;
    return sum[0]['SUM(money)'] as int;
  }catch (e) {
    // 打印错误信息
    print('Failed to insert data: $e');
    return 0;
  }
}
Future<int> getNowDaySend(Database db) async {
  try {
    // 查询所有数据
    DateTime now = DateTime.now(); // 获取当前日期时间
    int monthStart = DateTime(now.year, now.month, now.day).millisecondsSinceEpoch; // 获取本月第一天的日期时间
    int monthEnd = DateTime(now.year, now.month, now.day, 23, 59, 59, 999).millisecondsSinceEpoch; // 获取本月最后一天的日期时间（时间为23:59:59）
    List<Map<String, Object?>> sum = await db.rawQuery('SELECT SUM(money) FROM sendList WHERE date < ${monthEnd} AND date > ${monthStart} ;') ;
    return sum[0]['SUM(money)'] as int;
  }catch (e) {
    // 打印错误信息
    return 0;
  }
}
Future<int> getThisMounthSend(Database db) async {
  try {
    // 查询所有数据
    DateTime now = DateTime.now(); // 获取当前日期时间
    int monthStart = DateTime(now.year, now.month, 1).millisecondsSinceEpoch; // 获取本月第一天的日期时间
    int monthEnd = DateTime(now.year, now.month + 1, 0, 23, 59, 59).millisecondsSinceEpoch; // 获取本月最后一天的日期时间（时间为23:59:59）
    List<Map<String, Object?>> sum = await db.rawQuery('SELECT SUM(money) FROM sendList WHERE date < ${monthEnd} AND date > ${monthStart} ;') ;
    return sum[0]['SUM(money)'] as int;
  }catch (e) {
    // 打印错误信息
    return 0;
  }
}
Future<List<SendItem>> queryAll(Database db) async {
  try {
    // 查询所有数据
    final List<Map<String, dynamic>> maps = await db.query('sendList',orderBy: 'date DESC');

    return List.generate(maps.length, (i) {

      return SendItem(
        maps[i]['type'],
        maps[i]['money'],
        maps[i]['date'],
        maps[i]['id'],
      );
    });
  }catch (e) {
    // 打印错误信息
    print('Failed to insert data: $e');
    return [];
  }

}

