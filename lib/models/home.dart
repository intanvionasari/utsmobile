import 'package:flutter/material.dart';//mengimport material
import 'package:sqflite/sqflite.dart';//mengimport sqflitr untuk database
import 'dart:async';
import 'dbhelper.dart';//import class dbhelper
import 'entryForm.dart';//import class entry form
import 'item.dart';//import class item

//pendukung program asinkron
class Home extends StatefulWidget {//menggunakan stateful widget
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  DbHelper dbHelper = DbHelper();//memanggil fungsi dbhelper
  int count = 0;//membuat variabel count dengan tipe integer
  List<Item> itemList;//membuat list Item
  @override
  Widget build(BuildContext context) {
    updateListView();//digunakan untuk update list setelah di CRUD
    if (itemList == null) {//kondisi jika item list sama dengan null
      itemList = List<Item>();
    }
    return Scaffold(
      appBar: AppBar(//mengatur appbar
        title: Text('Daftar Barang'),//judul pada app bar
        leading: new IconButton(//membuat icon pada app bar
        icon : new Icon(Icons.home,//gambar icon
          color: Colors.white,//warna pada icon
        ), onPressed: () => Navigator.pop(context),),//navigasi jika memencet icon akan kembali ke page sebelumnya
        actions : <Widget> [//digunakan agar icon bisa lebih dari 1
            new IconButton(icon: new Icon(Icons.add, color:Colors.white),//menambahkan icon
        onPressed: () async {//kondisi jika icon dipencet
                var item = await navigateToEntryForm(context, null);
                if (item != null) {
                  //TODO 2 Panggil Fungsi untuk Insert ke DB
                  int result = await dbHelper.insert(item);
                  if (result > 0) {
                    updateListView();//menguptade list setelah diinsertkan
                  }
                }
              },
      ),
        ]
      ),
      body: Column(children: [//membuat kolom
        Expanded(//agar tidak overflowed
          child: createListView(),//memanggil fungsi created list view
        ),
      ]),
    );
  }

  Future<Item> navigateToEntryForm(BuildContext context, Item item) async {//digunakan untuk form barang
    var result = await Navigator.push(context,//navigasi 
        MaterialPageRoute(builder: (BuildContext context) {
      return EntryForm(item);//mengembalikan nilai entry form dg membawa data item
    }));
    return result;
  }

  ListView createListView() {//membuat fungsi create list view
    TextStyle textStyle = Theme.of(context).textTheme.headline5;//mengatur style text
    return ListView.builder(//membuat list builder
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(//membuat card
         child : ListTile(//membuat listtile
           title: Text(//text untuk judul
              this.itemList[index].name,//mengambil data name yang telah diinputkan
              style: textStyle,//style pada text
            ),
            subtitle: Text("Harga " + this.itemList[index].price.toString()//mengambil data harga yang telah diinputkan
            + " ,Kode " + this.itemList[index].kode //mengambil data kode yang telah diinputkan
            + " ,Stok " + this.itemList[index].stock.toString()),//menagmbil data stok yang telah diinputkan
            trailing: GestureDetector(
              child: Icon(Icons.delete),//memberi icon pada card
              onTap: () async {//jika icon dipencet akan menghapus data 
                //TODO 3 Panggil Fungsi untuk Delete dari DB berdasarkan Item
                int result = await dbHelper.delete(itemList[index].id);//memanggil fungsi delete
                if (result > 0){//kondisi jika result lebih dari 0
                  updateListView();//akan memanggil fungsi update listview
                }
              },
            ),
            onTap: () async {//jika card ditekan maka akan mengedit data
              var item =
              await navigateToEntryForm(context,this.itemList[index]);
              //TODO 4 Panggil Fungsi Untuk Edit data
              int result = await dbHelper.update(item);//memanggil fungsi update
              if (result > 0){//kondisi jika result lebih dari 0
                updateListView();//akan mengupdate list view
              }
            },
            leading: CircleAvatar(//membuat gambar agar membentuk lingkaran
              child: Text(this.itemList[index].name[0], // ambil karakter pertama text
                      style: TextStyle(fontSize: 20),//mengatur besar text
            ),
            ),  
         ),  
          );
      },
    );
  }

  //update List item
  void updateListView() {//membuat fungsi updatelistview
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      //TODO 1 Select data dari DB
      Future<List<Item>> itemListFuture = dbHelper.getItemList();//memanggil fungsi getItemList
      itemListFuture.then((itemList) {
        setState(() {
          this.itemList = itemList;
          this.count = itemList.length;
        });
      });
    });
  }
}
