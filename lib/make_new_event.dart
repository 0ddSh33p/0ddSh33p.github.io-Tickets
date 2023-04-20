import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class NewEvent extends StatefulWidget {
  const NewEvent({super.key});

  @override
  State<NewEvent> createState() {
    return _NewEventState();
  }
}

class _NewEventState extends State<NewEvent> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _date = TextEditingController();
  Future<Event>? _futureEvent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _title,
              decoration: InputDecoration(
                hintText: 'Event Title',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an event title';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _description,
              decoration: InputDecoration(
                hintText: 'Event Description',
              ),
              maxLines: 5,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an event description';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _date,
              decoration: InputDecoration(
                hintText: 'Event Date',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an event date';
                }
                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            FilledButton(
                onPressed: () {
                  _localPath;
                },
                child: Text('Event Forms')),
            SizedBox(
              height: 10,
            ),
            FilledButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _futureEvent = createEvent(
                          _title.text, _description.text, _date.text);
                    });
                  }
                },
                child: Text('Submit')),
            SizedBox(
              height: 20,
            ),
            FutureBuilder<Event>(
              future: _futureEvent,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                      'Event: ${snapshot.data!.title}. Description: ${snapshot.data!.description}');
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}

Future<Event> fetchEvent() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/users/1/albums'));
  if (response.statusCode == 200) {
    return Event.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

List<Event> parseEvents(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Event>((json) => Event.fromJson(json)).toList();
}

Future<Event> createEvent(String title, String description, String date) async {
  final response = await http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
      'description': description,
      'date': date,
    }),
  );

  if (response.statusCode == 201) {
    return Event.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create event');
  }
}

class Event {
  final int id;
  final String title;
  final String description;
  final String date;

  const Event(
      {required this.id,
      required this.title,
      required this.description,
      required this.date});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: json['date'],
    );
  }
}

Future<Event> deleteEvent(String id) async {
  final http.Response response = await http.delete(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    return Event.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to delete album.');
  }
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

List<Widget> makeEventList(Future<List<Event>> _futureEvents) {
  List<Widget> list = [];
  list.add(Text('Example Event'));
  // for(var i = 0; i < _futureEvents; i++){
  //   list.add(FutureBuilder<Event>(
  //     future: _futureEvents.get(i),
  //     builder: (context, snapshot) {
  //       if (snapshot.hasData) {
  //         return Text('Event: ${snapshot.data!.title}. Description: ${snapshot.data!.description}');
  //       } else if (snapshot.hasError) {
  //         return Text('${snapshot.error}');
  //       }
  //         return const CircularProgressIndicator();
  //     },
  //   ));
  // }
  return list;
}
