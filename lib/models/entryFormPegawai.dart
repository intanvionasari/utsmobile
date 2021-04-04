import 'package:flutter/material.dart';//mengimport material
import 'pegawai.dart';//import class pegawai

class EntryFormPegawai extends StatefulWidget {//menggunakan stateful widget karena widget akan mengalami perubahan
  final Pegawai pegawai;//membuat final pegawai untuk mengirimkan data
  EntryFormPegawai(this.pegawai);//digunakan untuk mengambil data dari class pegawai
  @override
  EntryFormPegawaiState createState() => EntryFormPegawaiState(this.pegawai);
}

//class controller
class EntryFormPegawaiState extends State<EntryFormPegawai> {
  Pegawai pegawai;
  EntryFormPegawaiState(this.pegawai);
  TextEditingController nameController = TextEditingController();//membuat controller nama
  TextEditingController jabatanController = TextEditingController();//membuat controller jabatan
  @override
  Widget build(BuildContext context) {
    //kondisi
    if (pegawai != null) {//kondisi jika pegawai tidak sama dengan null
      nameController.text = pegawai.name;//mengambil data name dari pegawai
      jabatanController.text= pegawai.jabatan;//mengambil data jabatan dari pegawai
    }
    //rubah
    return Scaffold(
        appBar: AppBar(
          title: pegawai == null ? Text('Tambah') : Text('Ubah'),//mengatur title dengan kondisi
          leading: new IconButton(icon : new Icon(Icons.arrow_back_rounded,//memberi icon pada app bar
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context, pegawai),//jika ikon back dipencet maka akan kembali ke halaman sebelumnya
          ),
           actions : <Widget> [//digunakan agar bisa menambah icon 
            new IconButton(icon: new Icon(Icons.check_outlined,color:Colors.white),//membuat icon button
            onPressed: (){//perintah jika diklik
                          if (pegawai == null) {//kondisi jika pegawai samadengan null maka melakukan tambah data
                            // tambah data
                            pegawai = Pegawai(
                              nameController.text,//tambah pada data nama
                              jabatanController.text//tambah pda data jabatan
                            );
                          } else {
                            // ubah data
                            pegawai.name = nameController.text;//mengubah nama
                            pegawai.jabatan = jabatanController.text;//mengubah jabatan
                          }
                          // kembali ke layar sebelumnya dengan membawa objek pegawai
                          Navigator.pop(context, pegawai);
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
              // nama
              Padding(//membuat padding
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),//mengatur jarak padding
                child: TextField(//membuat kolom inputan
                  controller: nameController,//memanggil controller nama
                  keyboardType: TextInputType.text,//tipe keyboard
                  decoration: InputDecoration(//memberi dekorasi pada kolom input
                    labelText: 'Nama Pegawai',//text di dalam kolom input
                    icon : Icon(Icons.account_circle),//memberi icon
                    border: OutlineInputBorder(//garis pada kolom
                      borderRadius: BorderRadius.circular(5.0),//tebal garis
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),
              // jabatan
              Padding(//membuat padding
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),//mengatur jarak padding
                child: TextField(//membuat kolom inputan
                  controller: jabatanController,//memanggil controller jabatan
                  keyboardType: TextInputType.text,//tipe keyboard
                  decoration: InputDecoration(//memberi dekorasi pada kolom input
                    labelText: 'Jabatan ',//text di dalam kolom input
                    icon : Icon(Icons.account_circle_outlined),//memberi icon
                    border: OutlineInputBorder(//garis pada kolom
                      borderRadius: BorderRadius.circular(5.0),//atur ketebalan garis
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
