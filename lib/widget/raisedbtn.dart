
import 'package:flutter/material.dart';

class Raisedbtn extends StatelessWidget {
  const Raisedbtn({
    @required this.perhitunganRumus,
    Key key,
  }) : super(key: key);

final Function perhitunganRumus;
  @override
  Widget build(BuildContext context) {
    return Container(//container untuk button
      width: 150,//mengatur lebar button
      height: 50,//mengatur tinggi button
      child: RaisedButton(//membuat raised button
       onPressed: perhitunganRumus,//memanggil fungsi perhitunganRumus jika diklik buttonnya
        child: Text("Hitung"),//text 
        splashColor: Colors.white10,//efek jika diklik ada warna putih
        textColor: Colors.black,//warna pada text button
        color: Colors.blueGrey,//warna buttonnya
      ),
    );
  }
}
