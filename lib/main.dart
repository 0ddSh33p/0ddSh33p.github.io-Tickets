import 'package:big_ticket1/account_info.dart';
import 'package:big_ticket1/admin.dart';
import 'package:big_ticket1/change_password.dart';
import 'package:big_ticket1/forms.dart';
import 'package:big_ticket1/join_event.dart';
import 'package:big_ticket1/osp_button.dart';
import 'package:big_ticket1/afterSubmit.dart';
import 'package:big_ticket1/parser.dart';
import 'package:big_ticket1/retreiveticket.dart';
import 'package:flutter/material.dart';
import '_buildmaterialcolor.dart';
import '_purplebutton.dart';
import '_events_page_student.dart';
import '_login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch:
            buildMaterialColor(const Color.fromARGB(255, 4, 84, 156)),
      ),
      initialRoute: "/login",
      routes: {
        //replace with loading page
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const StudentSignUp(),
        '/event': (context) => const FirstRoute(),
        '/formsubmit': (context) => afterSubmissionPage(),
        '/admin': (context) => const AdminPage(),
        '/osp': (context) => const OSPPage(),
        '/forms': (context) => FormsPage(),
        '/join': (context) => JoinEventPage(),
        '/update': (context) => UpdatePassword(),
        '/account': (context) => AccountInfoPage(),
        '/parsing': (context) => ParseingPage(),
        '/ticket': (context) => Retrival(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Big Ticket'),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(30.0),
            child: Container(
              color: const Color.fromRGBO(230, 230, 230, 1.0),
              child: Row(
                children: [
                  CallButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FirstRoute()),
                        );
                      },
                      text: 'test1'),
                  CallButton(onPressed: () {}, text: 'test2'),
                  CallButton(onPressed: () {}, text: 'test5'),
                  CallButton(onPressed: () {}, text: 'test4'),
                ],
              ),
            )),
      ),
      body: const Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: LoginPage()),
    );
  }
}

class TextFieldWidget extends StatefulWidget {
  final String message;
  const TextFieldWidget({
    Key? key,
    required this.message,
  }) : super(key: key);
  @override
  TextFieldWidgetState createState() => TextFieldWidgetState();
}

class TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(
    BuildContext context,
  ) {
    return SizedBox(
      width: 200.0,
      child: TextFormField(
        // The validator receives the text that the user has entered.
        style: const TextStyle(fontSize: 40),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return widget.message;
          }
          //This validator only checks for empty fields, but this can be where
          //the system checks if a username exists
          return null;
        },
      ),
    );
  }
}
