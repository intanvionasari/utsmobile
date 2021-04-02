
import 'package:flutter/material.dart';

class Hasil extends StatelessWidget {
  const Hasil({
    Key key,
    @required double result,
  }) : _result = result, super(key: key);

  final double _result;

  @override
  Widget build(BuildContext context) {
    return Container(//container
      margin: EdgeInsets.only(top: 20, bottom: 20),//mengatur jarak dengan margin atas dan bawah
      child: Column(//child berisi kolom
        mainAxisAlignment: MainAxisAlignment.center,//mainAxis untuk mengatur jarak kebawah
        children: [
          Text(
            "Anda Membutuhkan Keramik Sebanyak",//text
            style: TextStyle(//untuk textstyle seperti bold dan ukuran font
                fontWeight: FontWeight.bold, fontSize: 15.0),
          ),
          Text(
            _result.toStringAsFixed(1),//menampilkan result yang sudah diproses hitung
            style: TextStyle(fontSize: 30),//style text untuk result
          ),
          Text(
            "Biji",//text
            style: TextStyle(fontSize: 20.0),//style text
          ),
        ],
      ),
    );
  }
}
