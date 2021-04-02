import 'package:flutter/material.dart';//import material
import 'item.dart';//import pada class item

class EntryForm extends StatefulWidget {//menggunakan statefulwidget karena widget berubah
  final Item item;//membuat final item
  EntryForm(this.item);
  @override
  EntryFormState createState() => EntryFormState(this.item);
}

//class controller
class EntryFormState extends State<EntryForm> {
  Item item;
  EntryFormState(this.item);
  TextEditingController nameController = TextEditingController();//membuat controller name
  TextEditingController priceController = TextEditingController();//membuat controller price
  TextEditingController stockController = TextEditingController();//membuat controller stock
  TextEditingController kodeController = TextEditingController();//membuat controller kode
  @override
  Widget build(BuildContext context) {
    //kondisi
    if (item != null) {//kondisi jika item tidak sama dengan null
      kodeController.text = item.kode;//memanggil class item atribut kode
      nameController.text = item.name;//memanggil class item atribut name
      priceController.text = item.price.toString();//memanggil class item atribut price dengan menjadikan string dari int
      stockController.text = item.stock.toString();//memanggil class item atribut stock dengan menjadikan string dari int
    }
    //rubah
    return Scaffold(
        appBar: AppBar(//mengatur app bar
          title: item == null ? Text('Tambah') : Text('Ubah'),//title pada app bar dengan kondisi
          leading: new IconButton(icon : new Icon(Icons.arrow_back_rounded,//menggunakan icon yang bisa diklik
          color: Colors.white,//warna icon
        ),
        onPressed: () => Navigator.pop(context, item),//jika diklok akan kembali ke page sebelumnya
          ),
           actions : <Widget> [//membuat widget
            new IconButton(icon: new Icon(Icons.check_outlined,color:Colors.white),//membuat icon centang
            onPressed: (){//perintah jika diklik
                          if (item == null) {//kondisi jika item samadengan null maka melakukan tambah data
                            // tambah data
                            item = Item(
                              kodeController.text,//tambah pada atribut kode
                              nameController.text,//tambah pada atribut name
                              int.parse(priceController.text),//tambah pada atribut price
                              int.parse(stockController.text)//tambah pada atribut stock
                            );
                          } else {//kondisi selain item samadengan null
                            // melakukan ubah data
                            item.kode = kodeController.text;//ubah pada atribut kode
                            item.name = nameController.text;//ubah pada atribut kname
                            item.price = int.parse(priceController.text);//ubah pada atribut price
                            item.stock = int.parse(stockController.text);//ubah pada atribut stock
                          }
                          // kembali ke layar sebelumnya dengan membawa objek item
                          Navigator.pop(context, item);
            },
            ),
           ],    
            ),
        
        body: Padding(//membuat padding
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),//mengatur jarak padding
          child: ListView(//membuat tampilan list view
            children: <Widget>[//membuat widget
              Image.network(//mengambil gambar secara online
                  'https://w7.pngwing.com/pngs/815/307/png-transparent-diy-store-business-household-hardware-building-materials-store-retail-people-business-thumbnail.png',
                  width: 300.0,//mengatur lebar dan tinggi gambar
                  height: 200.0),
              // kode
              Padding(//membuat padding
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),//mengatur jarak atas dan bawah padding
                child: TextField(//membuat text inputan
                  controller: kodeController,//memanggil kontroller kode
                  keyboardType: TextInputType.text,//tipe keyboard text
                  decoration: InputDecoration(//dekorasi
                    labelText: 'Kode Barang',//label text pada kolom input
                    icon : Icon(Icons.format_list_numbered),//menambah icon pada samping kolom input
                    border: OutlineInputBorder(//haris input
                      borderRadius: BorderRadius.circular(5.0),//ukuran garis
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),
              // nama
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),//mengatur jarak atas dan bawah padding
                child: TextField(//membuat kolom inputan
                  controller: nameController,//memanggil name controller
                  keyboardType: TextInputType.text,//tipe keyboard
                  decoration: InputDecoration(//membuat dekorasi pada inputan
                    labelText: 'Nama Barang',//text pada kolom inputan
                    icon : Icon(Icons.carpenter_sharp),//menambah icon pada samping kolom input
                    border: OutlineInputBorder(//garis pada kolom inputan
                      borderRadius: BorderRadius.circular(5.0),//besar garis
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),
              // harga
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),//mengatur jarak atas dan bawah padding
                child: TextField(
                  controller: priceController,//memanggil price controller
                  keyboardType: TextInputType.number,//tipe keyboard
                  decoration: InputDecoration(//membuat dekorasi pada inputan
                    labelText: 'Harga',//text pada kolom inputan
                    icon : Icon(Icons.money),//menambah icon pada samping kolom input
                    border: OutlineInputBorder(//garis pada kolom inputan
                      borderRadius: BorderRadius.circular(5.0),//besar garis
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),
              // stock
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),//mengatur jarak atas dan bawah padding
                child: TextField(
                  controller: stockController,//memanggil price controller
                   keyboardType: TextInputType.number,//tipe keyboard
                  decoration: InputDecoration(//membuat dekorasi pada inputan
                    labelText: 'Stock Barang',//text pada kolom inputan
                    icon : Icon(Icons.add_shopping_cart_outlined),//menambah icon pada samping kolom input
                    border: OutlineInputBorder(//garis pada kolom inputan
                      borderRadius: BorderRadius.circular(5.0),//besar garis
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
