import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:big_ticket1/_purplebutton.dart';

class afterSubmissionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Big Ticket'),
        ),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("BG.png"), fit: BoxFit.cover)),
          height: double.infinity,
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.fromLTRB(50.0, 100.0, 50.0, 50.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 7),
                color: Colors.white,
              ),
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(50, 80, 50, 80),
                  child: Column(children: <Widget>[
                    Text(
                      "Your Permission Form Has Been Submitted!",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      "FOR THOSE BRINGING A NON-DRHS GUEST, PLEASE READ",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "In order for a non-DRHS guest to be admitted to the dance, you and your guest must print and fill out the following Non-DRHS Guest Registration Form. Any guests attending other high schools must also give this form to their school administrator to permit their attendance to the DRHS dance.",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Non-DRHS Guest Registration Forms must be turned in to Ms. Schultz BEFORE tickets are passed out.",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(height: 40),
                    ElevatedButton(
                        onPressed: _goToGuestForm,
                        child: Text("Link to Non-DRHS Guest Registration Form"))
                  ])),
            ),
          ),
        ));
  }

  Future<void> _goToGuestForm() async {
    final Uri _url = Uri.parse(
        'https://drive.google.com/file/d/10lbl52dNUd8EtyMwMR7CEHC-efoI_cst/view?usp=sharing');
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}
