import 'package:flutter/material.dart';//mengimport material
import 'package:sqflite/sqflite.dart';//mengimport sqflitr untuk database
import 'dart:async';
import 'dbhelper.dart';//import class dbhelper
import 'entryFormPelanggan.dart';//import class entry form pel
import 'pelanggan.dart';//import class item

//pendukung program asinkron
class HomePel extends StatefulWidget {//menggunakan stateful widget
  @override
  HomePelState createState() => HomePelState();
}

class HomePelState extends State<HomePel> {
  DbHelper dbHelper = DbHelper();//memanggil fungsi dbhelper
  int count = 0;//membuat variabel count dengan tipe integer
  List<Pelanggan> pelangganList;//membuat list pelanggan
  @override
  Widget build(BuildContext context) {
     updateListView();//digunakan untuk update list setelah di CRUD
    if (pelangganList == null) {//kondisi jika item list sama dengan null
      pelangganList = List<Pelanggan>();
    }
    return Scaffold(
      appBar: AppBar(//mengatur appbar
        title: Text('Data Pelanggan Order'),//judul pada app bar
        leading: new IconButton(//membuat icon pada app bar
        icon : new Icon(Icons.home,//gambar icon
          color: Colors.white,//warna pada icon
        ), onPressed: () => Navigator.pop(context),),//navigasi jika memencet icon akan kembali ke page sebelumnya
        actions : <Widget> [//digunakan agar icon bisa lebih dari 1
            new IconButton(icon: new Icon(Icons.group_add_sharp, color:Colors.white),//menambahkan icon
        onPressed: () async {//kondisi jika icon dipencet
                var pelanggan = await navigateToEntryForm(context, null);
                if (pelanggan != null) {
                  //TODO 2 Panggil Fungsi untuk Insert ke DB
                  int result = await dbHelper.insertpel(pelanggan);
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
  Future<Pelanggan> navigateToEntryForm(BuildContext context, Pelanggan pelanggan) async {//digunakan untuk form barang
    var result = await Navigator.push(context,//navigasi 
        MaterialPageRoute(builder: (BuildContext context) {
      return EntryFormPelanggan(pelanggan);//mengembalikan nilai entry form dg membawa data pelanggan
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
              this.pelangganList[index].name,//mengambil data name yang telah diinputkan
              style: textStyle,
            ),
            subtitle: Text("No. Tlep : " + this.pelangganList[index].nomor),//mengambil data nomor yang telah diinputkan
            trailing: GestureDetector(
              child: Icon(Icons.delete),//memberi icon pada card
              onTap: () async {//jika icon dipencet akan menghapus data
                //TODO 3 Panggil Fungsi untuk Delete dari DB berdasarkan Item
                int result = await dbHelper.deletepel(pelangganList[index].id);//memanggil fungsi delete
                if (result > 0){//kondisi jika result lebih dari 0
                  updateListView();//akan memanggil fungsi update listview
                }
              },
            ),
            onTap: () async {//jika card ditekan maka akan mengedit data
              var pelanggan =
              await navigateToEntryForm(context,this.pelangganList[index]);
              //TODO 4 Panggil Fungsi Untuk Edit data
              int result = await dbHelper.updatepel(pelanggan);//memanggil fungsi update pel
              if (result > 0){//kondisi jika result lebih dari 0
                updateListView();//akan mengupdate list view
              }
            },
            leading: CircleAvatar(//membuat gambar agar membentuk lingkaran
              child: Text(this.pelangganList[index].name[0], // ambil karakter pertama text
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
      Future<List<Pelanggan>> pelangganListFuture = dbHelper.getPelangganList();//memanggil fungsi getItemList
      pelangganListFuture.then((pelangganList) {
        setState(() {
          this.pelangganList = pelangganList;
          this.count = pelangganList.length;
        });
      });
    });
  }
}