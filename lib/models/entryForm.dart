import 'package:flutter/material.dart';
import 'item.dart';

class EntryForm extends StatefulWidget {
  final Item item;
  EntryForm(this.item);
  @override
  EntryFormState createState() => EntryFormState(this.item);
}

//class controller
class EntryFormState extends State<EntryForm> {
  Item item;
  EntryFormState(this.item);
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController kodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //kondisi
    if (item != null) {
      kodeController.text = item.kode;
      nameController.text = item.name;
      priceController.text = item.price.toString();
      stockController.text = item.stock.toString();
    }
    //rubah
    return Scaffold(
        appBar: AppBar(
          title: item == null ? Text('Tambah') : Text('Ubah'),
          leading: new IconButton(icon : new Icon(Icons.arrow_back_rounded,
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context, item),
          ),
           actions : <Widget> [
            new IconButton(icon: new Icon(Icons.check_outlined,color:Colors.white),
            onPressed: (){
                          if (item == null) {
                            // tambah data
                            item = Item(
                              kodeController.text,
                              nameController.text,
                              int.parse(priceController.text),
                              int.parse(stockController.text)
                            );
                          } else {
                            // ubah data
                            item.kode = kodeController.text;
                            item.name = nameController.text;
                            item.price = int.parse(priceController.text);
                            item.stock = int.parse(stockController.text);
                          }
                          // kembali ke layar sebelumnya dengan membawa objek item
                          Navigator.pop(context, item);
            },
            ),
           ],    
            ),
        
        body: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: ListView(
            children: <Widget>[
              Image.network(//mengambil gambar secara online
                  'https://w7.pngwing.com/pngs/815/307/png-transparent-diy-store-business-household-hardware-building-materials-store-retail-people-business-thumbnail.png',
                  width: 300.0,//mengatur lebar gambar
                  height: 200.0),
              // kode
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: kodeController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Kode Barang',
                    icon : Icon(Icons.format_list_numbered),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),
              // nama
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Nama Barang',
                    icon : Icon(Icons.carpenter_sharp),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),
              // harga
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Harga',
                    icon : Icon(Icons.money),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    //
                  },
                ),
              ),
              // stock
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: stockController,
                   keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Stock Barang',
                    icon : Icon(Icons.add_shopping_cart_outlined),
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
