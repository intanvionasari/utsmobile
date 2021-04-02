class Pelanggan {//membuat class pelanggan
  int _id;//atribut id dengan tipe data integer
  String _name;//atribut name dengan tipe data string
  String _nomor;//atribut nomor dengan tipe data string

  //membuat setter dan getter pada tiap atribut
  int get id => _id;
  String get name => this._name;
  set name(String value) => this._name = value;
  String get nomor => this._nomor;
  set nomor(String value) => this._nomor = value;



// konstruktor versi 1
  Pelanggan(this._name,this._nomor);


// konstruktor versi 2: konversi dari Map ke Item
  Pelanggan.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._nomor = map['nomor'];
  }

  
  // konversi dari Item ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['name'] = name;
    map['nomor'] = nomor;
    return map;
  }
}


