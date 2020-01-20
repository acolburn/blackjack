import 'package:flutter/material.dart';

Container makeInfoCell(String name) {
  return Container(
    decoration: BoxDecoration(border: Border.all()),
    padding: EdgeInsets.all(6.0),
    width: 90,
    child: Text(name, style: TextStyle(fontSize: 10)),
  );
}

Container makeInfoCellButton(
    {@required String name, @required Function action}) {
  return Container(
    // decoration: BoxDecoration(border: Border.all()),
    padding: EdgeInsets.all(6.0),
    width: 95,
    height: 50,
    child: RaisedButton(
      color: Colors.grey,
      child: Text(name, style: TextStyle(fontSize: 11)),
      onPressed: action,
    ),
  );
}
