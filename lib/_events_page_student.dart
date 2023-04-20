import 'package:flutter/material.dart';
import '_event_page_student.dart';
import '_purplebutton.dart';
import '_login_box.dart';

final List<String> entries = <String>['Event A', 'Homecoming 2023', 'Prom!'];
//final List<Widget> routes = <Widget>[FirstRoute(), 500, 100];

class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 60,
        leading: Image.asset('assets/logo.png'),
        leadingWidth: 60,
        backgroundColor: Color.fromRGBO(35, 60, 145, 1.0),
        title: const Text(
          'Big Ticket',
          style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
        ),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(30.0),
            child: Container(
              color: Color.fromRGBO(230, 230, 230, 1.0),
              child: Row(
                children: [
                  CallButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/event');
                      },
                      text: 'Your Events'),
                  CallButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/join');
                      },
                      text: 'Join Event'),
                  CallButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/account');
                      },
                      text: 'Account Info'),
                ],
              ),
            )),
      ),
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("BG.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              width: 6,
              color: Colors.black,
            ),
            const ListViewEvents(),
            Container(
              width: 6,
              color: Colors.black,
            ),
          ])),
    );
  }
}

List<List<String>> data1 = [
  [
    "Prom 2023",
    "Mrs. Robin E. Schultz",
    "Saturday, April 15th 2023",
    "7:00 p.m.",
    "Hippodrome Theatre",
    "\$50"
  ],
];

class ListViewEvents extends StatelessWidget {
  const ListViewEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(children: [
            const SizedBox(
              width: 500,
              height: 75,
              child: Text("Your Events",
                  style: TextStyle(
                      color: Color.fromARGB(255, 147, 39, 143),
                      fontSize: 70,
                      fontWeight: FontWeight.w800)),
            ),
            Expanded(
                child: ListView.separated(
              padding: const EdgeInsets.all(8),
              itemCount: entries.length,
              itemBuilder: (BuildContext context, int index) {
                return CallButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EventPage(
                                eventData: data1[index], image: "ticket.png")),
                      );
                    },
                    text: entries[index]);
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            )),
          ]),
        ),
      ),
    );
  }
}
