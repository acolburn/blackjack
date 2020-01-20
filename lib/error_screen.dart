import 'package:flutter/material.dart';

List<DataRow> rowList = [];

void addRow(String hand, String player, String recommended) {
  rowList.add(
    DataRow(
      cells: <DataCell>[
        DataCell(
          Text(hand),
        ),
        DataCell(
          Text(player),
        ),
        DataCell(
          Text(recommended),
        ),
      ],
    ),
  );
}

class ErrorScreen extends StatefulWidget {
  ErrorScreen({Key key}) : super(key: key);

  @override
  _ErrorScreenState createState() => _ErrorScreenState();
}

class _ErrorScreenState extends State<ErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Hand')),
                  DataColumn(label: Text('Player')),
                  DataColumn(label: Text('Recommended')),
                ],
                rows: rowList,
              ),
            ),
            RaisedButton(
              child: Text('Back'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
