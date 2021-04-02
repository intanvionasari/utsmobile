
import 'package:flutter/material.dart';

class Dropdown extends StatelessWidget {
  const Dropdown({
    Key key,
    @required this.listItem,
    @required String newValue,
    @required this.dropDownOnChanged,
  }) : _newValue = newValue, super(key: key);

  final List<String> listItem;
  final String _newValue;
  final Function dropDownOnChanged;

  @override
  Widget build(BuildContext context) {
    return Container(//container
      child: DropdownButton<String>(//child yang berisi berisi dropdown button
        items: listItem.map((String value) {//digunakan untuk pilihan list pada dropdown
          return DropdownMenuItem<String>(
            value: value,//mengatur value
            child: Text(value),//text pada dropdown yang berisi value 
          );
        }).toList(),//untuk listnya
        value: _newValue,//memperbarui value atau memilih value
        onChanged: dropDownOnChanged,//memanggil fungsi agar dapat mengganti atau memilih list
      ),
    );
  }
}