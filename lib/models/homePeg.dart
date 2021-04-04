import 'package:flutter/material.dart';//mengimport material
import 'package:sqflite/sqflite.dart';//mengimport sqflite untuk database
import 'dart:async';
import 'dbhelper.dart';//mengiport class dbhelper
import 'entryFormPegawai.dart';//mengimport class entry form pegawai
import 'pegawai.dart';//mengimport class pegawai

//pendukung program asinkron
class HomePeg extends StatefulWidget {//menggunakan stateful widget
  @override
  HomePegState createState() => HomePegState();
}

class HomePegState extends State<HomePeg> {
  DbHelper dbHelper = DbHelper();//memanggil fungsi dbhelper
  int count = 0;//membuat variabel count dengan tipe integer
  List<Pegawai> pegawaiList;//membuat list pegawai
  @override
  Widget build(BuildContext context) {
     updateListView();//digunakan untuk update list setelah di CRUD
    if (pegawaiList == null) {//kondisi jika item list sama dengan null
      pegawaiList = List<Pegawai>();
    }
    return Scaffold(
      appBar: AppBar(//mengatur appbar
        title: Text('Data Pegawai'),//judul pada app bar
        leading: new IconButton(//membuat icon pada app bar
        icon : new Icon(Icons.home,//gambar icon
          color: Colors.white,//warna pada icon
        ), onPressed: () => Navigator.pop(context),),//navigasi jika memencet icon akan kembali ke page sebelumnya
        actions : <Widget> [//digunakan agar icon bisa lebih dari 1
            new IconButton(icon: new Icon(Icons.group_add_sharp, color:Colors.white),//menambahkan icon
        onPressed: () async {//kondisi jika icon dipencet
                var pegawai = await navigateToEntryForm(context, null);
                if (pegawai != null) {
                  //TODO 2 Panggil Fungsi untuk Insert ke DB
                  int result = await dbHelper.insertpeg(pegawai);
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
  Future<Pegawai> navigateToEntryForm(BuildContext context, Pegawai pegawai) async {//digunakan untuk formpegawai
    var result = await Navigator.push(context,//navigasi
        MaterialPageRoute(builder: (BuildContext context) {
      return EntryFormPegawai(pegawai);//mengembalikan nilai entry form dg membawa data pegawai
    }));
    return result;
  }

  ListView createListView() {//membuat fungsi create list view
    TextStyle textStyle = Theme.of(context).textTheme.headline5;//mengatur style text
    return ListView.builder(//membuat list builder
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(//membuat tampilan card
         child : ListTile(//membuat list tile
           title: Text(//untuk judul pada card
              this.pegawaiList[index].name,//mengambil data nama dari pegawai list
              style: textStyle,//style text
            ),
            subtitle: Text("Jabatan : " + this.pegawaiList[index].jabatan),//untk subtitle card mengambil data jabatan dari tabel pegawai
            trailing: GestureDetector(
              child: Icon(Icons.delete),//icon didalam card
              onTap: () async {//kondisi jika icon delete dipencet
                //TODO 3 Panggil Fungsi untuk Delete dari DB berdasarkan Pegawai
                int result = await dbHelper.deletepeg(pegawaiList[index].id);//akan memanggil fungsi delete pegawai
                if (result > 0){
                  updateListView();//mengupdate list view setelah didelete
                }
              },
            ),
            onTap: () async {//kondisi jika card dipencet
              var pegawai =
              await navigateToEntryForm(context,this.pegawaiList[index]);
              //TODO 4 Panggil Fungsi Untuk Edit data
              int result = await dbHelper.updatepeg(pegawai);//akan melakukan update pegawai
              if (result > 0){
                updateListView();//updete list view setelah dilakukan perubahan
              }
            },
            leading: CircleAvatar(//membuat poto profil lingkaran
              child: Text(this.pegawaiList[index].name[0], // ambil karakter pertama text
                      style: TextStyle(fontSize: 20),//besar text
            ),
            ),  
         ),  
          );
      },
    );
  }

  //update List item
  void updateListView() {//digunakan untuk mengupdate list
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      //TODO 1 Select data dari DB
      Future<List<Pegawai>> pegawaiListFuture = dbHelper.getPegawaiList();//memanggil fungsi getItemList
      pegawaiListFuture.then((pegawaiList) {
        setState(() {
          this.pegawaiList = pegawaiList;
          this.count = pegawaiList.length;
        });
      });
    });
  }
}