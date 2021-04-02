import 'package:flutter/material.dart';
import 'pelanggan.dart';

class EntryFormPelanggan extends StatefulWidget {
  final Pelanggan pelanggan;
  EntryFormPelanggan(this.pelanggan);
  @override
  EntryFormPelangganState createState() => EntryFormPelangganState(this.pelanggan);
}

//class controller
class EntryFormPelangganState extends State<EntryFormPelanggan> {
  Pelanggan pelanggan;
  EntryFormPelangganState(this.pelanggan);
  TextEditingController nameController = TextEditingController();
  TextEditingController nomorController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //kondisi
    if (pelanggan != null) {
      nameController.text = pelanggan.name;
      nomorController.text= pelanggan.nomor;
    }
    //rubah
    return Scaffold(
        appBar: AppBar(
          title: pelanggan == null ? Text('Tambah') : Text('Ubah'),
          leading: new IconButton(icon : new Icon(Icons.arrow_back_rounded,
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context, pelanggan),
          ),
           actions : <Widget> [
            new IconButton(icon: new Icon(Icons.check_outlined,color:Colors.white),
            onPressed: (){
                          if (pelanggan == null) {
                            // tambah data
                            pelanggan = Pelanggan(
                              nameController.text,
                              nomorController.text
                            );
                          } else {
                            // ubah data
                            pelanggan.name = nameController.text;
                            pelanggan.nomor = nomorController.text;
                          }
                          // kembali ke layar sebelumnya dengan membawa objek item
                          Navigator.pop(context, pelanggan);
            },
            ),
           ],    
            ),
        
        body: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: ListView(
            children: <Widget>[
              Image.network(//mengambil gambar secara online
                  'https://macpoin.com/wp-content/uploads/2018/09/whatsapp-fitur-baru-iphone.jpg',
                  width: 300.0,//mengatur lebar gambar
                  height: 200.0),              
              // nama
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Nama Pelanggan',
                    icon : Icon(Icons.account_circle),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),
              // nomer
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: nomorController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Nomer Telepon',
                    icon : Icon(Icons.call_sharp),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
