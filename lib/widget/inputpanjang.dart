
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Inputpanjang extends StatelessWidget {
  const Inputpanjang({
    Key key,
    @required this.inputpjController,
  }) : super(key: key);

  final TextEditingController inputpjController;

  @override
  Widget build(BuildContext context) {
    return Container(
      //container
      padding: EdgeInsets.all(5.0), //mengatur jarak
      child: TextFormField(
        //membuat text form(kolom yang bisa diisi)
        controller: inputpjController, //memanggil controller
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly
        ], //validasi hanya digit
        keyboardType: TextInputType.number, //tipe keyboard
        decoration: new InputDecoration(
            //dekorasi textformfield
            hintText:
                "Masukkan Panjang Ruangan(meter)", //text pada textformfield
            icon: Icon(Icons.home_outlined), //icon pada textformfield
            border: OutlineInputBorder(
                //border pada textformfield
                borderRadius: new BorderRadius.circular(
                    2.0))), //border pada textformfield
      ),
    );
  }
}