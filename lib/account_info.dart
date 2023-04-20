import 'package:flutter/material.dart';
import '_event_page_student.dart';
import '_purplebutton.dart';
import '_login_box.dart';

class AccountInfoPage extends StatelessWidget {
  AccountInfoPage({super.key});
  // event data items are, in order, name, owner, date, time, location, admission price

  final List<String> exAccount = <String>[
    'Jane Doe',
    'hcps-doej',
    'hcps-doej@henricostudents.org'
  ];

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
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("BG.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            LoginBox(fieldArray: [
              SizedBox(
                  width: 500,
                  height: 150,
                  child: SizedBox(
                      width: 500,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Divider(),
                            Text("Name: ${exAccount[0]}",
                                style: TextStyle(fontSize: 18)),
                            SizedBox(height: 5),
                            Text("Student ID: ${exAccount[1]}",
                                style: TextStyle(fontSize: 18)),
                            SizedBox(height: 5),
                            Text("Email: ${exAccount[2]}",
                                style: TextStyle(fontSize: 18)),
                            SizedBox(height: 5),
                            const Divider(),
                            SizedBox(height: 10),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/update');
                                },
                                child: Text("Update Password"))
                          ])))
            ], title: "Account Info"),
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

final List<String> entries = <String>['Event A', 'Homecoming 2023', 'Prom!'];

class ListViewEvents extends StatelessWidget {
  const ListViewEvents({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 500,
        child: Column(children: [
          SizedBox(
            width: 400,
            height: 75,
            child: Text("Upcoming Events",
                style: TextStyle(
                    color: Color.fromARGB(255, 147, 39, 143),
                    fontSize: 30,
                    fontWeight: FontWeight.w800)),
          ),
          Expanded(
              child: ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: entries.length,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(entries[index] + " (${data1[0][2]})"),
                  SizedBox(width: 10),
                  CallButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EventPage(
                                  eventData: data1[index],
                                  image: "ticket.png")),
                        );
                      },
                      text: "Join"),
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          )),
        ]));
  }
}
