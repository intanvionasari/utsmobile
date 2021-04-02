import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dbhelper.dart';
import 'entryFormPelanggan.dart';
import 'pelanggan.dart';

//pendukung program asinkron
class HomePel extends StatefulWidget {
  @override
  HomePelState createState() => HomePelState();
}

class HomePelState extends State<HomePel> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  List<Pelanggan> pelangganList;
  @override
  Widget build(BuildContext context) {
     updateListView();
    if (pelangganList == null) {
      pelangganList = List<Pelanggan>();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Pelanggan Order'),
        leading: new IconButton(
        icon : new Icon(Icons.home,
          color: Colors.white,
        ), onPressed: () => Navigator.pop(context),),
        actions : <Widget> [
            new IconButton(icon: new Icon(Icons.group_add_sharp, color:Colors.white),
        onPressed: () async {
                var pelanggan = await navigateToEntryForm(context, null);
                if (pelanggan != null) {
                  //TODO 2 Panggil Fungsi untuk Insert ke DB
                  int result = await dbHelper.insertpel(pelanggan);
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
  Future<Pelanggan> navigateToEntryForm(BuildContext context, Pelanggan pelanggan) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return EntryFormPelanggan(pelanggan);
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
              this.pelangganList[index].name,
              style: textStyle,
            ),
            subtitle: Text("No. Tlep : " + this.pelangganList[index].nomor),
            trailing: GestureDetector(
              child: Icon(Icons.delete),
              onTap: () async {
                //TODO 3 Panggil Fungsi untuk Delete dari DB berdasarkan Item
                int result = await dbHelper.deletepel(pelangganList[index].id);
                if (result > 0){
                  updateListView();
                }
              },
            ),
            onTap: () async {
              var pelanggan =
              await navigateToEntryForm(context,this.pelangganList[index]);
              //TODO 4 Panggil Fungsi Untuk Edit data
              int result = await dbHelper.updatepel(pelanggan);
              if (result > 0){
                updateListView();
              }
            },
            leading: CircleAvatar(
              child: Text(this.pelangganList[index].name[0], // ambil karakter pertama text
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
      Future<List<Pelanggan>> pelangganListFuture = dbHelper.getPelangganList();
      pelangganListFuture.then((pelangganList) {
        setState(() {
          this.pelangganList = pelangganList;
          this.count = pelangganList.length;
        });
      });
    });
  }
}