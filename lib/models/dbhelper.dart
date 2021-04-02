import 'package:sqflite/sqflite.dart';//mengimpor package sqflite
import 'dart:async';//mengimport asyc
import 'dart:io';//mengimport io
import 'package:path_provider/path_provider.dart';//mengimport package path provider
import 'item.dart';//mengimport class item
import 'pelanggan.dart';//mengimport class pelanggan

class DbHelper {//membuat class dbhelper
 static DbHelper _dbHelper;//membuat variabel dbleper
 static Database _database;//membuat variabel database
 DbHelper._createObject();//membuat object
 Future<Database> initDb() async {
 //untuk menentukan nama database dan lokasi yg dibuat
 Directory directory = await getApplicationDocumentsDirectory();
 String path = directory.path + 'item.db';//database dengan nama item

 //create, read databases
 var itemDatabase = openDatabase(path, version: 5, onCreate: _createDb, onUpgrade: _onUpgrade);

 //mengembalikan nilai object sebagai hasil dari fungsinya
 return itemDatabase;
 }

 //untuk upgrade database
 void _onUpgrade(Database db, int oldVersion, int newVersion){
   _createDb(db,newVersion);
 }
 
 //buat tabel baru 
 void _createDb(Database db, int version) async {//perintah membuat tabel item dg atribut id,kode,name,price,stock
 await db.execute('''
 CREATE TABLE item (
 id INTEGER PRIMARY KEY AUTOINCREMENT,
 kode TEXT,
 name TEXT,
 price INTEGER,
 stock INTEGER
 )
 ''');
//membuat tabel kedua pelanggan dengan atribut id,name,dan nomor
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
 var mapList = await db.query('item', orderBy: 'name');//variabel maplist untuk select tabel item serta diurutkan berdasarkan name
return mapList;//mereturn maplist
 }

 //select tabel ke 2 yaitu pelanggan
 Future<List<Map<String, dynamic>>> selectpel() async {
 Database db = await this.initDb();
 var mapList = await db.query('pelanggan', orderBy: 'name');//variabel maplist untuk select tabel pelanggan serta diurutkan berdasarkan name
return mapList;
 }
 
//insert pada tabel item 
 Future<int> insert(Item object) async {//perintah insert dengan method select
 Database db = await this.initDb();
 int count = await db.insert('item', object.toMap());//insert pada tabel item
 return count;//mereturn variabel count
 }

 //insert pada tabel kedua pelanggan
 Future<int> insertpel(Pelanggan object) async {//perintah insert dg metod insertpel
 Database db = await this.initDb();
 int count = await db.insert('pelanggan', object.toMap());//insert pada tabel pelanggan
 return count; //mereturn variable count
 }

//update item
 Future<int> update(Item object) async {//perintah update tabel dg method update
 Database db = await this.initDb();
 int count = await db.update('item', object.toMap(),//update tabel item
 where: 'id=?',//memeriksa id
 whereArgs: [object.id]);
 return count;//mereturn var count
 }

 //update pelanggan
 Future<int> updatepel(Pelanggan object) async {//perintah update dg method updetpel
 Database db = await this.initDb();
 int count = await db.update('pelanggan', object.toMap(),//update pada tabel pelanggan
 where: 'id=?',
 whereArgs: [object.id]);
 return count;//mengembalikan nilai count
 }


 //delete pd tabel item
 Future<int> delete(int id) async {//perintah delete dg method delete
 Database db = await this.initDb();
 int count = await db.delete('item',//delete pada tabel item
 where: 'id=?',//memeriksa id
 whereArgs: [id]);
 return count;//mengembalikan nilai count
 }

 //delete pada tabel pelanggan
 Future<int> deletepel(int id) async {//perintah delete dg method deletepel
 Database db = await this.initDb();
 int count = await db.delete('pelanggan',//delete tabel pelanggan
 where: 'id=?',//memeriksa id
 whereArgs: [id]);
 return count;//mengembalikan nilai count
 }

//tabel item
 Future<List<Item>> getItemList() async {//membuat list pada tabel item
 var itemMapList = await select();//men select tabel item
 int count = itemMapList.length;//count samadengan panjang maplist
 List<Item> itemList = List<Item>();
 for (int i=0; i<count; i++) {//perulangan pada count
 itemList.add(Item.fromMap(itemMapList[i]));//perintah add pada item
 }
 return itemList;//mengembalikan nilai itemList
 }

 //tabel pelanggan
 Future<List<Pelanggan>> getPelangganList() async {//membuat list pada tabel pelanggan
 var pelangganMapList = await selectpel();//men select tabel pelanggan
 int count = pelangganMapList.length;
 List<Pelanggan> pelangganList = List<Pelanggan>();
 for (int i=0; i<count; i++) {//perulangan pada count
 pelangganList.add(Pelanggan.fromMap(pelangganMapList[i]));//perintah add pada tabel pelanggan
 }
 return pelangganList;//mengembalikan nilai pelangganlist
 }

 factory DbHelper() {//method dbhelper
 if (_dbHelper == null) {//kondisi jika dbhelper null
 _dbHelper = DbHelper._createObject();//maka akan membuat object
 }
 return _dbHelper;//mengembalikan nilai dbhelper
 }
 Future<Database> get database async {
 if (_database == null) {//kondisi jika database null
 _database = await initDb();//maka akan memanggil fungsi initDb
 }
 return _database;//menembalikan nilai database
 }
}