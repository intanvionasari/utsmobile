import 'package:flutter/material.dart';//mengimport material
import 'pelanggan.dart';//import class pelanggan

class EntryFormPelanggan extends StatefulWidget {//menggunakan stateful widget karena widget akan mengalami perubahan
  final Pelanggan pelanggan;//membuat final pelanggan
  EntryFormPelanggan(this.pelanggan);//digunakan untuk mengambil data dari class pelanggan
  @override
  EntryFormPelangganState createState() => EntryFormPelangganState(this.pelanggan);
}

//class controller
class EntryFormPelangganState extends State<EntryFormPelanggan> {
  Pelanggan pelanggan;
  EntryFormPelangganState(this.pelanggan);
  TextEditingController nameController = TextEditingController();//membuat controller untuk name
  TextEditingController nomorController = TextEditingController();//membuat controller untuk nomor
  @override
  Widget build(BuildContext context) {
    //kondisi
    if (pelanggan != null) {//kondisi jika pelanggan tidak sama dengan null
      nameController.text = pelanggan.name;//controller mengambil data nama
      nomorController.text= pelanggan.nomor;//controller mengambil data nomor
    }
    //rubah
    return Scaffold(//return scaffold
        appBar: AppBar(//mengatur app bar
          title: pelanggan == null ? Text('Tambah') : Text('Ubah'),//mengatur title dengan kondisi
          leading: new IconButton(icon : new Icon(Icons.arrow_back_rounded,//memberi icon pada app bar
          color: Colors.white,//warna pada icon
        ),
        onPressed: () => Navigator.pop(context, pelanggan),//jika ikon back dipencet maka akan kembali ke halaman sebelumnya
          ),
           actions : <Widget> [//digunakan agar bisa menambah icon 
            new IconButton(icon: new Icon(Icons.check_outlined,color:Colors.white),//membuat icon button
            onPressed: (){//kondisi jika icon dipencet
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
        
        body: Padding(//membuat padding
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),//mengatur jarak padding
          child: ListView(//membuat list view
            children: <Widget>[
              Image.network(//mengambil gambar secara online
                  'https://macpoin.com/wp-content/uploads/2018/09/whatsapp-fitur-baru-iphone.jpg',
                  width: 300.0,//mengatur lebar dan tinggi gambar
                  height: 200.0),              
              // kolom untuk nama
              Padding(//membuat padding
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),//mengatur jarak padding
                child: TextField(//membuat kolom textfield
                  controller: nameController,//memanggil controller untuk kolom name
                  keyboardType: TextInputType.text,//tipe keyboard
                  decoration: InputDecoration(//dekorasi untuk kolom textfield
                    labelText: 'Nama Pelanggan',//text pada kolom inputan
                    icon : Icon(Icons.account_circle),//memberi hiasan icon 
                    border: OutlineInputBorder(//memberi border pada kolom inputan
                      borderRadius: BorderRadius.circular(5.0),//atur ketebalan border
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),
              // komom untuk nomor
              Padding(//membuat padding
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),//mengatur jarak padding
                child: TextField(//membuat kolom inputan
                  controller: nomorController,//memanggil controller untuk nomor
                  keyboardType: TextInputType.number,//tipe pada keyboard
                  decoration: InputDecoration(//dekorasi untuk kolom
                    labelText: 'Nomer Telepon',//text pada dalam kolom
                    icon : Icon(Icons.call_sharp),//memberi icon
                    border: OutlineInputBorder(//memberi garis border pada kolom
                      borderRadius: BorderRadius.circular(5.0),//mengatur ketebalan border
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
