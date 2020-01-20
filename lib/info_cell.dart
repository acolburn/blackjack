import 'package:flutter/material.dart';

Container makeInfoCell(String info) {
  return Container(
    decoration: BoxDecoration(border: Border.all()),
    padding: EdgeInsets.all(6.0),
    width: 90,
    child: Text(info, style: TextStyle(fontSize: 10)),
  );
}
