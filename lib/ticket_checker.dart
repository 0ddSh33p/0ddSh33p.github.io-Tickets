import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class TicketCheck extends StatefulWidget{
  const TicketCheck({super.key});

  @override
  State<TicketCheck> createState() => _TicketCheckState();
}

class _TicketCheckState extends State<TicketCheck> {
  late Future<Ticket> _futureTicket;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ticket = TextEditingController();

  @override
  void initState() {
    super.initState();
    //_futureTicket = fetchTicket();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _ticket,
              validator:(value) {
                if(value == null || value.isEmpty){ //
                  return 'Not a ticket';
                }
                return null;
              },
              onFieldSubmitted: (value) {
                FutureBuilder<Ticket>(
              future: _futureTicket,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: const Text('Delete Ticket?'),
                          content: const Text('Ticket will be deleted forever'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                _futureTicket = deleteTicket(_ticket.text);
                                Navigator.pop(context, 'Delete Ticket');
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                }
                return const CircularProgressIndicator();
              }
            );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Student {
  final String first;
  final String last;
  final String email;
  final String password;
  final Iterable<Ticket> tickets;

  const Student({required this.first, required this.last, required this.password, required this.email, required this.tickets});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      first: json['first'],
      last: json['last'],
      email: json['email'],
      password: json['password'],
      tickets: (json['tickets'] as Iterable).map<Ticket>(
        (value) => Ticket.fromJson(value as Map<String, dynamic>),
      ),
    );
  }
}

class Ticket{
  final String id;
  final String eventId;

  const Ticket({required this.id, required this.eventId});

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'],
      eventId: json['eventId'],
    );
  }
}

Future<Ticket> updateAlbum(String title) async {
  final response = await http.put(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': title,
    }),
  );

  if (response.statusCode == 200) {
    return Ticket.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to update ticket');
  }
}

Future<Ticket> fetchTicket() async {
  final response = await http.get(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
  );

  if (response.statusCode == 200) {
    return Ticket.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load ticket');
  }
}

Future<Ticket> deleteTicket(String id) async {
  final http.Response response = await http.delete(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    return Ticket.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to delete album.');
  }
}
