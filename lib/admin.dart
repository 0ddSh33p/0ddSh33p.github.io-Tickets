import 'package:flutter/material.dart';
import 'make_new_event.dart';
import 'ticket_checker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class AdminPage extends StatefulWidget{
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  //List<Widget> _events = makeEventList();

  @override
  void initState() {
    super.initState();
    //_events = makeEventList(fetchEvents());
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Row(
            children: [
              FilledButton.icon(
                icon: const Icon(Icons.add_rounded),
                label: const Text('Add New Event'),
                onPressed: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(builder: (context) => const NewEvent()),
                  );
                },
              ),
              const SizedBox(width: 20,),
              FilledButton.icon(
                icon: const Icon(Icons.close_rounded),
                label: const Text('Delete Event'),
                onPressed: () {
                  //_futureEvent = deleteEvent(id);
                },
              ),
            ],
          ),
          //ListView(
            //children: _events, 
          //),
          Container(
            decoration: BoxDecoration(
              border: Border.all(),
              shape: BoxShape.rectangle,
            ),
            child: const Text('Events would go here'),
          ),
          const SizedBox(height: 20,),
          FilledButton(
            child: const Text('Crate New Admin'),
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => const AdminCreator()),
              );
            },
          ),
          const SizedBox(height: 20,),
          FilledButton(
            onPressed: (){
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => const TicketCheck()),
              );
            }, 
            child: const Text('Check in tickets'),
          ),
        ],
      ),
    );
  }
}

class AdminCreator extends StatefulWidget{
  const AdminCreator({super.key});

  @override
  State<AdminCreator> createState() => _AdminCreatorState();
}

class _AdminCreatorState extends State<AdminCreator> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _first = TextEditingController();
  final TextEditingController _last = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _passwordCon = TextEditingController();
  Future<Admin>? _futureAdmin;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          children: [
            const SizedBox(height: 40),
            SizedBox(
              width: 200,
              height: 50,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  controller: _first,
                  style: const TextStyle(fontSize: 12.5),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'First Name',
                    hintStyle: TextStyle(fontSize: 12.5),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 200,
              height: 50,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  controller: _last,
                  style: const TextStyle(fontSize: 12.5),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Last Name',
                    hintStyle: TextStyle(fontSize: 12.5),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 200,
              height: 50,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  controller: _email,
                  style: const TextStyle(fontSize: 12.5),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Email',
                    hintStyle: TextStyle(fontSize: 12.5),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 200,
              height: 50,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  controller: _password,
                  obscureText: true,
                  style: const TextStyle(fontSize: 12.5),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Password',
                    hintStyle: TextStyle(fontSize: 12.5),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 200,
              height: 50,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: TextFormField(
                  controller: _passwordCon,
                  obscureText: true,
                  style: const TextStyle(fontSize: 12.5),
                  validator: (value) {
                    if(_password.text != _passwordCon.text){
                      return 'Make sure passwords match';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Confirm Password',
                    hintStyle: TextStyle(fontSize: 12.5),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            FilledButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    _futureAdmin = createAdmin(_first.text, _last.text, _email.text, _password.text);
                  });
                }
              }, 
              child: const Text('Create New Admin'),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class Admin {
  final String first;
  final String last;
  final String email;
  final String password;

  const Admin({required this.first, required this.last, required this.password, required this.email});

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      first: json['first'],
      last: json['last'],
      email: json['email'],
      password: json['password'],
    );
  }
}

Future<Admin> createAdmin(String first, String last, String email, String password) async{
  final response = await http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/admins'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'first': first,
      'last': last,
      'email': email,
      'password': password,
    }),
  );

  if (response.statusCode == 201) {
    return Admin.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create admin.');
  }
}

