class Item {//membuat class item
  int _id;//atribut id dengan tipe data int
  String _name;//atribut name dengan tipe data string
  int _price;//atribut price dengan tipe data int
  int _stock;//atribut stock dengan tipe data int
  String _kode;//atribut kode dengan tipe data string


  //membuat setter dan getter pada masing-masing atribut
  int get id => _id;
  String get name => this._name;
  set name(String value) => this._name = value;
  get price => this._price;
  set price(value) => this._price = value;
  get stock => this._stock;
  set stock(value) => this._stock = value;
  String get kode => this._kode;
  set kode(String value) => this._kode = value;



// konstruktor versi 1
  Item(this._kode,this._name, this._price, this._stock);


// konstruktor versi 2: konversi dari Map ke Item
  Item.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._kode = map ['kode'];
    this._name = map['name'];
    this._price = map['price'];
    this._stock = map['stock'];
  }

  
  // konversi dari Item ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['kode'] = kode;
    map['name'] = name;
    map['price'] = price;
    map['stock'] = stock;
    return map;
  }
}


