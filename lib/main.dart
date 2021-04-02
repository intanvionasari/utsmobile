import 'package:flutter/material.dart';
import 'package:uts_intan/models/home.dart';

import 'models/homePel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikasi Toko Bangunan', //title aplikasi
      theme: ThemeData(
        primarySwatch: Colors.green, // warna tema
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
        home: Scaffold(
        resizeToAvoidBottomInset: false,//digunakan agar tidak overflowed
        appBar: AppBar(
          title: Text("TOKO BANGUNAN "), //title tampilan kanan atas aplikasi
        ),
        backgroundColor: Colors.white,
        body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.network(//mengambil gambar secara online
                  'https://dexpobangunan.files.wordpress.com/2015/06/20688_1388769734775162_1395825442704902278_n.png',
                  width: 200.0,//mengatur lebar gambar
                  height: 150.0),
          Raisedbtn(),
          Raisedbtn2(),
        ],)
      )
     )
   );
  }
}

class Raisedbtn extends StatelessWidget {
  const Raisedbtn({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton.icon(
      onPressed: (){  Navigator.push(//jika di pencet atau diklik akan berpindah halaman
        context,
        MaterialPageRoute(builder: (context) => new Home()//menyetting halaman yang dituju
        ),
      );
      },
      shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.all(Radius.circular(10.0))),
      label: Text('   Data Barang   ', 
             style: TextStyle(color: Colors.white),),
      icon: Icon(Icons.add_business_rounded, color:Colors.white,), 
      textColor: Colors.white,
      splashColor: Colors.white,
      color: Colors.green,);
  }
}
class Raisedbtn2 extends StatelessWidget {
  const Raisedbtn2({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton.icon(
            onPressed: (){  Navigator.push(//jika di pencet atau diklik akan berpindah halaman
        context,
        MaterialPageRoute(builder: (context) => new HomePel()//menyetting halaman yang dituju
        ),
      );
      },
            shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.all(Radius.circular(10.0))),
            label: Text('Data Pelanggan', 
                   style: TextStyle(color: Colors.white),),
            icon: Icon(Icons.account_box_sharp,color :Colors.white,), 
            textColor: Colors.white,
            splashColor: Colors.white,
            color: Colors.lightBlue,);
  }
}