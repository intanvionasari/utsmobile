
import 'package:flutter/material.dart';

class Textpertama extends StatelessWidget {
  const Textpertama({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(//container
      padding: EdgeInsets.only(top: 23.0),//padding untuk mengatur jarak hanya atas saja
      child: Text(//child yang berisi text
        'Pilih Ukuran Keramik',//text
        textAlign: TextAlign.center,//agar text berada di tengah atau center
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19.0),//style pada text
      ),
    );
  }
}

