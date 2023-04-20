import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:csv/csv.dart';
import 'dart:io';
import 'dart:convert';

//I tried to include what I thought was important, but I wasn't sure what was important.
class ParseingPage extends StatefulWidget {
  @override
  State<ParseingPage> createState() => _ParseingPageState();
}

class _ParseingPageState extends State<ParseingPage> {
  List<List<dynamic>> _data = [];

  void _loadCSV() async {
    final _rawData =
        //await rootBundle.loadString("assets/HomecomingReport1.csv");
        await rootBundle.loadString("assets/HomecomingTicketReport2.csv");
    List<List<dynamic>> _listData =
        const CsvToListConverter().convert(_rawData);
    setState(() {
      _data = _listData;
    });
    String jsonTags = jsonEncode(_rawData);
    print(jsonTags);
    json.decode(jsonTags);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("CSV test")),
      body: ListView.builder(
        itemCount: _data.length,
        itemBuilder: (_, index) {
          return Card(
            margin: const EdgeInsets.all(3),
            color: index == 0 ? Colors.amber : Colors.white,
            child: ListTile(
              leading: Text(_data[index][0].toString()),
              title: Text(_data[index][1]),
              trailing: Text(_data[index][2].toString()),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add), onPressed: _loadCSV),
    );
  }
}
