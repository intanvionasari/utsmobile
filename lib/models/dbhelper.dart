import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'item.dart';
import 'pelanggan.dart';

class DbHelper {
 static DbHelper _dbHelper;
 static Database _database;
 DbHelper._createObject();
 Future<Database> initDb() async {
 //untuk menentukan nama database dan lokasi yg dibuat
 Directory directory = await getApplicationDocumentsDirectory();
 String path = directory.path + 'item.db';

 //create, read databases
 var itemDatabase = openDatabase(path, version: 5, onCreate: _createDb, onUpgrade: _onUpgrade);

 //mengembalikan nilai object sebagai hasil dari fungsinya
 return itemDatabase;
 }

 //upgrade database
 void _onUpgrade(Database db, int oldVersion, int newVersion){
   _createDb(db,newVersion);
 }
 
 //buat tabel baru dengan nama item
 void _createDb(Database db, int version) async {
 await db.execute('''
 CREATE TABLE item (
 id INTEGER PRIMARY KEY AUTOINCREMENT,
 kode TEXT,
 name TEXT,
 price INTEGER,
 stock INTEGER
 )
 ''');

 await db.execute('''
 CREATE TABLE pelanggan(
 id INTEGER PRIMARY KEY AUTOINCREMENT,
 name TEXT,
 nomor TEXT
 )
 ''');
 
 }

//select databases
 Future<List<Map<String, dynamic>>> select() async {
 Database db = await this.initDb();
 var mapList = await db.query('item', orderBy: 'name');
return mapList;
 }

 //select databases 2
 Future<List<Map<String, dynamic>>> selectpel() async {
 Database db = await this.initDb();
 var mapList = await db.query('pelanggan', orderBy: 'name');
return mapList;
 }
 
//create databases
 Future<int> insert(Item object) async {
 Database db = await this.initDb();
 int count = await db.insert('item', object.toMap());
 return count;
 }

 //create databases 2
 Future<int> insertpel(Pelanggan object) async {
 Database db = await this.initDb();
 int count = await db.insert('pelanggan', object.toMap());
 return count;
 }


//update databases
 Future<int> update(Item object) async {
 Database db = await this.initDb();
 int count = await db.update('item', object.toMap(),
 where: 'id=?',
 whereArgs: [object.id]);
 return count;
 }

 //update databases pelanggan
 Future<int> updatepel(Pelanggan object) async {
 Database db = await this.initDb();
 int count = await db.update('pelanggan', object.toMap(),
 where: 'id=?',
 whereArgs: [object.id]);
 return count;
 }


 //delete databases
 Future<int> delete(int id) async {
 Database db = await this.initDb();
 int count = await db.delete('item',
 where: 'id=?',
 whereArgs: [id]);
 return count;
 }

 //delete databases 2
 Future<int> deletepel(int id) async {
 Database db = await this.initDb();
 int count = await db.delete('pelanggan',
 where: 'id=?',
 whereArgs: [id]);
 return count;
 }

//tabel item
 Future<List<Item>> getItemList() async {
 var itemMapList = await select();
 int count = itemMapList.length;
 List<Item> itemList = List<Item>();
 for (int i=0; i<count; i++) {
 itemList.add(Item.fromMap(itemMapList[i]));
 }
 return itemList;
 }

 //tabel pelanggan
 Future<List<Pelanggan>> getPelangganList() async {
 var pelangganMapList = await selectpel();
 int count = pelangganMapList.length;
 List<Pelanggan> pelangganList = List<Pelanggan>();
 for (int i=0; i<count; i++) {
 pelangganList.add(Pelanggan.fromMap(pelangganMapList[i]));
 }
 return pelangganList;
 }

 factory DbHelper() {
 if (_dbHelper == null) {
 _dbHelper = DbHelper._createObject();
 }
 return _dbHelper;
 }
 Future<Database> get database async {
 if (_database == null) {
 _database = await initDb();
 }
 return _database;
 }
}