import 'package:flutter/material.dart';
import '_purplebutton.dart';
import '_events_page_student.dart';

class EventPage extends StatelessWidget {
  const EventPage({super.key, required this.eventData, required this.image});
  // event data items are, in order, name, owner, date, time, location, admission price

  final List<String> eventData;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Big Ticket'),
      ),
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.width * .7 / 4,
          width: MediaQuery.of(context).size.width * .7,
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
          /*decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(image),
                fit: BoxFit.cover,
              ),
            ),*/
        ),
        Row(
          children: [
            Column(
              children: [
                const SizedBox(
                  width: 300,
                  height: 130,
                ),
                RoundedContainer(
                    color: 0xFF93278F, text: "Date: ${eventData[2]}"),
                const SizedBox(
                  width: 300,
                  height: 25,
                ),
                RoundedContainer(
                    color: 0xFF4C3E96, text: "Time: ${eventData[3]}"),
                const SizedBox(
                  width: 300,
                  height: 25,
                ),
                RoundedContainer(
                    color: 0xFF04549C, text: "Place: ${eventData[4]}"),
              ],
            ),
            Column(
              children: [
                const SizedBox(
                  height: 200,
                ),
                Text(
                  eventData[0],
                  style: const TextStyle(
                      fontSize: 40,
                      color: Color(0xFF93278F),
                      fontWeight: FontWeight.w900),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  "Courtesy of ${eventData[1]}, Admission price is ${eventData[5]}",
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 50,
                    ),
                    Container(
                      height: 100,
                      color: Colors.blue,
                      width: MediaQuery.of(context).size.width - 400,
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/forms',
                                  arguments: {
                                    'name': eventData[0],
                                    'host': eventData[1],
                                    'date': eventData[2],
                                    'time': eventData[3],
                                    'location': eventData[4],
                                    'cost': eventData[5],
                                  });
                            },
                            child: Text("Complete Permission Form"),
                          ),
                          Icon(Icons.check, color: Colors.greenAccent),
                          SizedBox(width: 20),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/osp');
                            },
                            child: Text("Buy Ticket"),
                          ),
                          Icon(Icons.clear, color: Colors.redAccent),
                          SizedBox(width: 20),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/ticket');
                              },
                              child: Text("See Ticket"))
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        )
      ]),
    );
  }
}

class RoundedContainer extends StatelessWidget {
  const RoundedContainer({
    super.key,
    required this.color,
    required this.text,
  });

  final int color;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300,
        height: 100,
        decoration: BoxDecoration(
          color: Color(color),
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
        ));
  }
}
