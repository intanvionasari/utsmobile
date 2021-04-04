import 'package:flutter/material.dart';//mengimport matrial
import 'package:uts_intan/models/home.dart';//mengimport class home
import 'package:uts_intan/models/homePeg.dart';
import 'models/hitung.dart';//import class hitung
import 'models/homePel.dart';//import class homePel

void main() => runApp(MyApp());//agar project bisa di run

class MyApp extends StatelessWidget {//menggunakan stateless widget

  @override
  Widget build(BuildContext context) {
    return MaterialApp(//return matrialapp
      debugShowCheckedModeBanner: false,//menghilangkan debugbanner
      title: 'Aplikasi Toko Bangunan', //title aplikasi
      theme: ThemeData(//mengatur tema
        primarySwatch: Colors.green, // warna tema
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
        home: Scaffold(
        resizeToAvoidBottomInset: false,//digunakan agar tidak overflowed
        appBar: AppBar(//mengatur app bar
          title: Text("TOKO BANGUNAN "), //title tampilan kanan atas aplikasi
        ),
        backgroundColor: Colors.white,//background
        body: Center(//agar tampilan ditengah
        child: Column(//membuat colom
        mainAxisAlignment: MainAxisAlignment.center,//mengatur jarak kolom
        children: <Widget>[
          Image.network(//mengambil gambar secara online
                  'https://dexpobangunan.files.wordpress.com/2015/06/20688_1388769734775162_1395825442704902278_n.png',
                  width: 200.0,//mengatur lebar dan tinggi gambar
                  height: 150.0),
          Raisedbtn(),//button pertama
          Raisedbtn0(),//button kedua
          Raisedbtn2(),//button ketiga
          Raisedbtn3(),//button keempat
        ],)
      )
     )
   );
  }
}

class Raisedbtn extends StatelessWidget {//extrack button agar bisa melakukan navigasi
  const Raisedbtn({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton.icon(//membuat raisedbutton
      onPressed: (){  Navigator.push(//jika di pencet atau diklik akan berpindah halaman
        context,
        MaterialPageRoute(builder: (context) => new Home()//menyetting halaman yang dituju
        ),
      );
      },
      shape: RoundedRectangleBorder(//agar button tidak terlalu kotak
             borderRadius: BorderRadius.all(Radius.circular(10.0))),
      label: Text('   Data Barang   ', //text pada button
             style: TextStyle(color: Colors.white),),
      icon: Icon(Icons.add_business_rounded, color:Colors.white,),//menambahkan icon pada button 
      textColor: Colors.white,//warna text button
      splashColor: Colors.white,//efek jika dipencet
      color: Colors.green,);//warna button
  }
}

class Raisedbtn0 extends StatelessWidget {//extrack button agar bisa melakukan navigasi
  const Raisedbtn0({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton.icon(//membuat raisedbutton
            onPressed: (){  Navigator.push(//jika di pencet atau diklik akan berpindah halaman
        context,
        MaterialPageRoute(builder: (context) => new HomePeg()//menyetting halaman yang dituju
        ),
      );
      },
            shape: RoundedRectangleBorder(//agar button tidak terlalu kotak
                   borderRadius: BorderRadius.all(Radius.circular(10.0))),
            label: Text(' Data Pegawai ', //text pada button
                   style: TextStyle(color: Colors.white),),
            icon: Icon(Icons.account_circle_rounded,color :Colors.white,),//icon pada button 
            textColor: Colors.white,//warna text button
            splashColor: Colors.white,//memberi efek jika dipencet
            color: Colors.greenAccent,);//warna button
  }
}



class Raisedbtn2 extends StatelessWidget {//extrack button agar bisa melakukan navigasi
  const Raisedbtn2({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton.icon(//membuat raisedbutton
            onPressed: (){  Navigator.push(//jika di pencet atau diklik akan berpindah halaman
        context,
        MaterialPageRoute(builder: (context) => new HomePel()//menyetting halaman yang dituju
        ),
      );
      },
            shape: RoundedRectangleBorder(//agar button tidak terlalu kotak
                   borderRadius: BorderRadius.all(Radius.circular(10.0))),
            label: Text('Data Pelanggan', //text pada button
                   style: TextStyle(color: Colors.white),),
            icon: Icon(Icons.account_box_sharp,color :Colors.white,),//icon pada button 
            textColor: Colors.white,//warna text button
            splashColor: Colors.white,//memberi efek jika dipencet
            color: Colors.lightBlue,);//warna button
  }
}


class Raisedbtn3 extends StatelessWidget {//extrack button agar bisa melakukan navigasi
  const Raisedbtn3({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton.icon(//membuat raised button
            onPressed: (){  Navigator.push(//jika di pencet atau diklik akan berpindah halaman
        context,
        MaterialPageRoute(builder: (context) => new Hitung()//menyetting halaman yang dituju
        ),
            );
            },
            shape: RoundedRectangleBorder(//agar button tidak terlalu kotak
                   borderRadius: BorderRadius.all(Radius.circular(10.0))),
            label: Text(' Hitung Keramik ', //text pada button
                   style: TextStyle(color: Colors.white),),//style text
            icon: Icon(Icons.calculate_rounded,color :Colors.white,), //memberikan icon pada button
            textColor: Colors.white,//warna text
            splashColor: Colors.white,//efek jika dipencet
            color: Colors.blue,);//warna button
  }
}