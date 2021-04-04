class Pegawai {//membuat class pegawai
  int _id;//membuat variabel id dengan tipe data int
  String _name;//membuat variabel nama dengan tipe data string
  String _jabatan;//membuat variabel jabatan dengan tipe data string
  
//membuat setter dan getter pada tiap atribut
  int get id => _id;
  String get name => this._name;
  set name(String value) => this._name = value;
  String get jabatan => this._jabatan;
  set jabatan(String value) => this._jabatan = value;



// konstruktor versi 1
  Pegawai(this._name,this._jabatan);


// konstruktor versi 2: konversi dari Map ke Item
  Pegawai.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._jabatan = map['jabatan'];
  }

  
  // konversi dari Item ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['name'] = name;
    map['jabatan'] = jabatan;
    return map;
  }
}


