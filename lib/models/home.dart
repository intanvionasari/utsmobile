import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dbhelper.dart';
import 'entryForm.dart';
import 'item.dart';

//pendukung program asinkron
class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<Item> itemList;
  @override
  Widget build(BuildContext context) {
    updateListView();
    if (itemList == null) {
      itemList = List<Item>();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Barang'),
        leading: new IconButton(
        icon : new Icon(Icons.home,
          color: Colors.white,
        ), onPressed: () => Navigator.pop(context),),
        actions : <Widget> [
            new IconButton(icon: new Icon(Icons.add, color:Colors.white),
        onPressed: () async {
                var item = await navigateToEntryForm(context, null);
                if (item != null) {
                  //TODO 2 Panggil Fungsi untuk Insert ke DB
                  int result = await dbHelper.insert(item);
                  if (result > 0) {
                    updateListView();
                  }
                }
              },
      ),
        ]
      ),
      body: Column(children: [
        Expanded(
          child: createListView(),
        ),
      ]),
    );
  }

  Future<Item> navigateToEntryForm(BuildContext context, Item item) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return EntryForm(item);
    }));
    return result;
  }

  ListView createListView() {
    TextStyle textStyle = Theme.of(context).textTheme.headline5;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
         child : ListTile(
           title: Text(
              this.itemList[index].name,
              style: textStyle,
            ),
            subtitle: Text("Harga " + this.itemList[index].price.toString()
            + " ,Kode " + this.itemList[index].kode 
            + " ,Stok " + this.itemList[index].stock.toString()),
            trailing: GestureDetector(
              child: Icon(Icons.delete),
              onTap: () async {
                //TODO 3 Panggil Fungsi untuk Delete dari DB berdasarkan Item
                int result = await dbHelper.delete(itemList[index].id);
                if (result > 0){
                  updateListView();
                }
              },
            ),
            onTap: () async {
              var item =
              await navigateToEntryForm(context,this.itemList[index]);
              //TODO 4 Panggil Fungsi Untuk Edit data
              int result = await dbHelper.update(item);
              if (result > 0){
                updateListView();
              }
            },
            leading: CircleAvatar(
              child: Text(this.itemList[index].name[0], // ambil karakter pertama text
                      style: TextStyle(fontSize: 20),
            ),
            ),  
         ),  
          );
      },
    );
  }

  //update List item
  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      //TODO 1 Select data dari DB
      Future<List<Item>> itemListFuture = dbHelper.getItemList();
      itemListFuture.then((itemList) {
        setState(() {
          this.itemList = itemList;
          this.count = itemList.length;
        });
      });
    });
  }
}
