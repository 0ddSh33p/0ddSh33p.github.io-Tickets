import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OSPPage extends StatefulWidget {
  const OSPPage({super.key});
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
  // This class is the configuration for the state.
  @override
  _OSPPageState createState() => _OSPPageState();
}

class _OSPPageState extends State<OSPPage> {
  int _counter = 0;

  void _gotoosp() {
    const url =
        'https://osp.osmsinc.com/HenricoVA/BVModules/CategoryTemplates/Detailed%20List%20with%20Properties/Category.aspx?categoryid=EH160';
    launchUrl(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Big Ticket'),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: _gotoosp,
                child: Text(
                  'Click the button to go to OSP',
                ))
          ],
        ),
      ),
    );
  }
}
