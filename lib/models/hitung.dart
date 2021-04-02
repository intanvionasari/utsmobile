import 'package:flutter/material.dart';//import material
import 'package:uts_intan/widget/dropdown.dart';//import library
import 'package:uts_intan/widget/hasil.dart';//import library
import 'package:uts_intan/widget/inputlebar.dart';//import library
import 'package:uts_intan/widget/inputpanjang.dart';//import library
import 'package:uts_intan/widget/raisedbtn.dart';//import library
import 'package:uts_intan/widget/textpertama.dart';//import library



class Hitung extends StatefulWidget {
  @override
  HitungState createState() => HitungState();
}

class HitungState extends State<Hitung> {
   double _inputPanjang = 0; //membuat variable
  double _inputLebar = 0; //membuat variable
  final inputpjController = TextEditingController(); //membuat controller
  final inputlbController = TextEditingController(); //membuat controller

  var listItem = ["30X30", "40X40", "50X50"]; //variable pada list
  List<String> listViewItem = List<String>(); //untuk list item
  String _newValue = "30X30"; // variable value
  double _result = 0; // variable result

  void dropDownOnChanged(String changeValue) {
    //fungsi untuk dropdown
    setState(() {
      _newValue = changeValue;//fungsi untuk mengubah value pada dropdown
    });
  }

  void perhitunganRumus() {
    //fungsi untuk mengitung rumus
    setState(() {
      _inputPanjang = double.parse(inputpjController.text);
      _inputLebar = double.parse(inputlbController.text);
      if (_newValue == "30X30") {
        //perhitungan jika ukuran keramik 30x30
        _result = ((_inputPanjang * 100) * (_inputLebar * 100)) / 900;
      } else if (_newValue == "40X40") {
        //perhitungan jika ukuran keramik 40x40
        _result = ((_inputPanjang * 100) * (_inputLebar * 100)) / 1600;
      } else //perhitungan jika ukuran keramik 50x50
        _result = ((_inputPanjang * 100) * (_inputLebar * 100)) / 2500;
     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,//digunakan agar tidak overflowed
        appBar: AppBar(
          title: Text('Hitung Keramik'),//title pada appbar
          leading: new IconButton(icon : new Icon(Icons.arrow_back_rounded,
          color: Colors.white,
        ),
        onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Container(
          //container
          margin: EdgeInsets.all(5), //mengatur jarak
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, //mengatur jarak
            children: [
              Image.network(//mengambil gambar secara online
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSd1eki1ZC4-4f7wgcG480nrY9Vc1SYuJx-3g&usqp=CAU',
                  width: 200.0,//mengatur lebar gambar
                  height: 150.0),//mengatur tinggi gambar
              Inputpanjang(inputpjController: inputpjController),//memanggil kelas Inputpanjang serta controllernya
              Inputlebar(inputlbController: inputlbController),//memanggil kelas Inputlebar serta controllernya
              Textpertama(),//memanggil kelas textpertama
              Dropdown(listItem: listItem, newValue: _newValue,dropDownOnChanged: dropDownOnChanged),//memanggil kelas dropdown dan fungsinya
              Hasil(result: _result),//memanggil kelas hasil 
              Raisedbtn(perhitunganRumus: perhitunganRumus,),//memanggil kelas raisedbtn beserta fungsi perhitugan rumus
            ],
          ),
        ),
    );
  }
}