// PDF making code + files come from https://github.com/SyncfusionExamples/create-a-pdf-document-in-flutter

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:signature/signature.dart';
import 'package:big_ticket1/pdf.dart';
import 'package:big_ticket1/afterSubmit.dart';
import 'package:big_ticket1/_purplebutton.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'mobile.dart' if (dart.library.html) 'web.dart';

class FormsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Big Ticket',
            style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
          ),
        ),
        body: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("BG.png"), fit: BoxFit.cover)),
            child: PermissionForm()));
  }
}

class PermissionForm extends StatefulWidget {
  @override
  PermissionFormState createState() => PermissionFormState();
}

// This widget is the root of your application.
class PermissionFormState extends State<PermissionForm> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final guestController = TextEditingController();
  String name = '';
  String guestName = '';
  Uint8List? signData;

  var data = {};

  final SignatureController _signcontrol = SignatureController(
    penStrokeWidth: 1,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  double getBottom(PdfLayoutResult result) {
    return result.bounds.bottom;
  }

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>;
    var date = data['date'];

    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.fromLTRB(50.0, 50.0, 50.0, 20.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 7),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Deep Run High School Procedures for Homecoming Dance ($date)",
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Text(
                    "Every student must complete and turn in this form when picking up ticket(s). Any student bringing a non-DRHS guest must also complete and return the Guest Registration Form. Please be sure that you and your guest are eligible before purchasing tickets.  No refunds will be given.",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(children: <Widget>[
                RichText(
                    text: const TextSpan(
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                      TextSpan(
                          text: "* ",
                          style: TextStyle(color: Colors.redAccent)),
                      TextSpan(text: "Deep Run Student Name: ")
                    ])),
                Flexible(
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      controller: nameController,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[800],
                      ),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(12.5),
                        isDense: true,
                        border: OutlineInputBorder(),
                        hintText: 'Ex: Jane Doe',
                        labelText: 'Enter your full name: ',
                      ),
                      validator: (value) {
                        print("do someting");
                        if (value == null || value.isEmpty) {
                          return 'Invalid input';
                        }
                        return null;
                      },
                      onSaved: (val) => name = val!,
                    ),
                  ),
                ),
              ]),
              const SizedBox(height: 50),
              const Text(
                "Who can attend?",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
              SizedBox(height: 10),
              const Text(
                "  \u2022 Any Deep Run High School student in good standing who is not specifically restricted from attending school events and extra-curricular activities.\n  \u2022 Guests: The Guest Registration portion of this form must be fully completed and returned before tickets will be distributed for a guest who is not a DRHS student. Make sure your guest is eligible before purchasing tickets.\n  \u2022 Students may only bring one guest.\n  \u2022 Eligible guests include students from other high schools who are in good standing at their home school and not more than 18 years old, and DRHS graduates who are not more than 20 years old accompanying a current student. Middle school students are NOT allowed to attend DRHS dances.",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Ticket Purchasing & Distribution:",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "  \u2022 Tickets are \$10 each and must be purchased in advance from September 17th through September 25th.\n  \u2022 Tickets must be purchased online through OSP.  No tickets will be sold during ticket distribution during the days prior to the dance.  NO tickets will be sold at the door.\n  \u2022 Tickets will be distributed to students beginning Tuesday, September 27th during One Lunch. Once distributed, lost tickets cannot be replaced.\n  \u2022 A ticket or tickets must be presented at the door to enter the dance for all students and guests.\n  \u2022 Students AND their guests MUST present a valid photo identification to enter.  A valid driver’s license, or school issued photo ID, or a paper photocopy of one of these ID’s will be accepted.",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Appropriate Dress:",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "  \u2022 Dress is casual formal / semi-formal.  Ladies’ dress selections should be compliant with DRHS Dress Code.\n  \u2022 Shoes must be worn at all times.  Students may want to bring flat shoes to change into at the dance.",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Appropriate Behavior:",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "  \u2022 All Henrico County Public Schools and Deep Run High School policies and expectations will apply before, during and after the event.\n  \u2022 Attendees are to remain in designated areas during the dance.  This is for everyone’s safety.\n  \u2022 All students MUST arrive prior to 8:30 p.m. as the doors will close to entry after that time.  Any student or guest arriving after 8:30pm will not be admitted.\n  \u2022 Once a student leaves the dance, re-entry is not allowed.  Students are not permitted to go outside of the building once they have entered unless they are leaving for the night.\n  \u2022 Attendees are expected to dance appropriately.  Any lewd dancing or behavior, including inappropriate back to front dancing, may result in dismissal from the dance and possible school consequences.  Any student or guest who continues to demonstrate this type of behavior will be escorted off the dance floor & from the event.\n  \u2022 Attendees are not permitted to bring or use any tobacco or tobacco-related products such as but not limited to cigarettes, e-cigarettes, dipping, or vaping at any time. This will result in dismissal from the dance and school consequences.",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  "STUDENT SOBRIETY AND BEHAVIOR EXPECTATION AGREEMENT",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Deep Run High School students and their guests are expected to follow Federal and State of Virginia laws regarding underage consumption and possession of alcohol, drugs, and weapons.",
                style: TextStyle(
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
              const Text(
                  "  \u2022 Any student/guest suspected of being under the influence of alcohol or drugs will be subject to further questioning by Deep Run High School administrators and/or the Henrico County Police.\n  \u2022 Any student/guest found to be intoxicated by alcohol or drugs or in the possession of any weapon (of any type) will be immediately removed from the dance, and student or guest emergency contacts, as well as Henrico County Police, will be notified.  The HCPS school code of conduct will apply.",
                  style: TextStyle(
                    fontSize: 14,
                  )),
              const SizedBox(height: 50),
              RichText(
                  text: const TextSpan(
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                    TextSpan(
                        text: "* ", style: TextStyle(color: Colors.redAccent)),
                    TextSpan(text: "DEEP RUN STUDENT SIGNATURE: ")
                  ])),
              const SizedBox(height: 10),
              Row(children: [
                Container(
                  width: 300,
                  height: 80,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Signature(
                    controller: _signcontrol,
                    width: 300,
                    height: 80,
                    backgroundColor: Colors.white,
                  ),
                ),
                IconButton(
                  iconSize: 36,
                  icon: Icon(Icons.clear, color: Colors.red),
                  onPressed: () => _signcontrol.clear(),
                ),
              ]),
              const SizedBox(height: 30),
              const Text(
                "(Optional) If you're bringing a guest, please provide the guest's full name: ",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                keyboardType: TextInputType.name,
                controller: guestController,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[800],
                ),
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(12.5),
                  isDense: true,
                  border: OutlineInputBorder(),
                  hintText: 'Ex: Jane Doe',
                  labelText: 'Enter guest\'s full name: ',
                ),
                onSaved: (val) => guestName = val!,
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.only(top: 40.0),
                child: ElevatedButton(
                  child: const Text('Submit'),
                  onPressed: () async {
                    Uint8List? temp = await _signcontrol.toPngBytes();
                    setState(() {
                      name = nameController.text;
                      signData = temp;
                      if (guestName != null) {
                        guestName = guestController.text;
                      }
                    });
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      if (signData != null) {
                        Navigator.pushReplacementNamed(context, '/formsubmit');
                        _createPDF(date);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text('Don\'t forget to add your signature.')),
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                'Please insert your name before submitting.')),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _createPDF(String date) async {
    PdfDocument document = PdfDocument();
    final PdfPage page = document.pages.add();

    //const String firstPara ='Every student must complete and turn in this form when picking up ticket(s). Any student bringing a\n non-DRHS guest must also complete and return the Guest Registration Form. Please be sure that you\n and your guest are eligible before purchasing tickets.  No refunds will be given.';

    PdfLayoutFormat layoutFormat = PdfLayoutFormat(
        layoutType: PdfLayoutType.paginate,
        breakType: PdfLayoutBreakType.fitPage);

    PdfTextElement textElement = PdfTextElement(
        text: 'Deep Run High School Procedures for Homecoming Dance ($date)',
        font: PdfStandardFont(PdfFontFamily.helvetica, 12,
            style: PdfFontStyle.bold));
    PdfTextElement textElement2 = PdfTextElement(
        text:
            'Every student must complete and turn in this form when picking up ticket(s). Any student bringing a\n non-DRHS guest must also complete and return the Guest Registration Form. Please be sure that you\n and your guest are eligible before purchasing tickets.  No refunds will be given.',
        font: PdfStandardFont(PdfFontFamily.helvetica, 11));
    PdfTextElement textElement3 = PdfTextElement(
        text: "Deep Run Student Name: __${name}__",
        font: PdfStandardFont(PdfFontFamily.helvetica, 12,
            style: PdfFontStyle.bold));
    PdfTextElement textElement4 = PdfTextElement(
        text: "Who can attend?",
        font: PdfStandardFont(PdfFontFamily.helvetica, 10,
            style: PdfFontStyle.underline));
    PdfUnorderedList bullets1 = PdfUnorderedList(
        text:
            "Any Deep Run High School student in good standing who is not specifically restricted from attending school events and extra-curricular activities.\nGuests: The Guest Registration portion of this form must be fully completed and returned before tickets will be distributed for a guest who is not a DRHS student. Make sure your guest is eligible before purchasing tickets.\nStudents may only bring one guest.\nEligible guests include students from other high schools who are in good standing at their home school and not more than 18 years old, and DRHS graduates who are not more than 20 years old accompanying a current student. Middle school students are NOT allowed to attend DRHS dances.",
        style: PdfUnorderedMarkerStyle.disk,
        font: PdfStandardFont(PdfFontFamily.helvetica, 10),
        indent: 10,
        textIndent: 10,
        format: PdfStringFormat(lineSpacing: 0));
    PdfTextElement textElement5 = PdfTextElement(
        text: "Ticket Purchasing & Distribution:",
        font: PdfStandardFont(PdfFontFamily.helvetica, 10,
            style: PdfFontStyle.underline));
    PdfUnorderedList bullets2 = PdfUnorderedList(
        text:
            "Tickets are \$10 each and must be purchased in advance from September 17th through September 25th.\nTickets must be purchased online through OSP.  No tickets will be sold during ticket distribution during the days prior to the dance.\nNO tickets will be sold at the door.\nTickets will be distributed to students beginning Tuesday, September 27th during One Lunch.  Once distributed, lost tickets cannot be replaced.\nA ticket or tickets must be presented at the door to enter the dance for all students and guests.\nStudents AND their guests MUST present a valid photo identification to enter.  A valid driver’s license, or school issued photo ID, or a paper photocopy of one of these ID’s will be accepted.",
        style: PdfUnorderedMarkerStyle.disk,
        font: PdfStandardFont(PdfFontFamily.helvetica, 10),
        indent: 10,
        textIndent: 10,
        format: PdfStringFormat(lineSpacing: 0));
    PdfTextElement textElement6 = PdfTextElement(
        text: "Appropriate Dress:",
        font: PdfStandardFont(PdfFontFamily.helvetica, 10,
            style: PdfFontStyle.underline));
    PdfUnorderedList bullets3 = PdfUnorderedList(
        text:
            "Dress is casual formal / semi-formal.  Ladies’ dress selections should be compliant with DRHS Dress Code.\nShoes must be worn at all times.  Students may want to bring flat shoes to change into at the dance.",
        style: PdfUnorderedMarkerStyle.disk,
        font: PdfStandardFont(PdfFontFamily.helvetica, 10),
        indent: 10,
        textIndent: 10,
        format: PdfStringFormat(lineSpacing: 0));
    PdfTextElement textElement7 = PdfTextElement(
        text: "Appropriate Behavior:",
        font: PdfStandardFont(PdfFontFamily.helvetica, 10,
            style: PdfFontStyle.underline));
    PdfUnorderedList bullets4 = PdfUnorderedList(
        text:
            "All Henrico County Public Schools and Deep Run High School policies and expectations will apply before, during and after the event.\nAttendees are to remain in designated areas during the dance.  This is for everyone’s safety.\nAll students MUST arrive prior to 8:30 p.m. as the doors will close to entry after that time.  Any student or guest arriving after 8:30pm will not be admitted.\nOnce a student leaves the dance, re-entry is not allowed.  Students are not permitted to go outside of the building once they have entered unless they are leaving for the night.\nAttendees are expected to dance appropriately.  Any lewd dancing or behavior, including inappropriate back to front dancing, may result in dismissal from the dance and possible school consequences.  Any student or guest who continues to demonstrate this type of behavior will be escorted off the dance floor & from the event.\nAttendees are not permitted to bring or use any tobacco or tobacco-related products such as but not limited to cigarettes, e-cigarettes, dipping, or vaping at any time. This will result in dismissal from the dance and school consequences.",
        style: PdfUnorderedMarkerStyle.disk,
        font: PdfStandardFont(PdfFontFamily.helvetica, 10),
        indent: 10,
        textIndent: 10,
        format: PdfStringFormat(lineSpacing: 0));
    PdfTextElement textElement8 = PdfTextElement(
        text: "STUDENT SOBRIETY AND BEHAVIOR EXPECTATION AGREEMENT",
        font: PdfStandardFont(PdfFontFamily.helvetica, 11,
            style: PdfFontStyle.underline));
    PdfTextElement textElement9 = PdfTextElement(
        text:
            "Deep Run High School students and their guests are expected to follow Federal and State of Virginia laws regarding underage consumption and possession of alcohol, drugs, and weapons.",
        font: PdfStandardFont(PdfFontFamily.helvetica, 10,
            style: PdfFontStyle.bold));
    PdfUnorderedList bullets5 = PdfUnorderedList(
        text:
            "Any student/guest suspected of being under the influence of alcohol or drugs will be subject to further questioning by Deep Run High School administrators and/or the Henrico County Police.\nAny student/guest found to be intoxicated by alcohol or drugs or in the possession of any weapon (of any type) will be immediately removed from the dance, and student or guest emergency contacts, as well as Henrico County Police, will be notified.  The HCPS school code of conduct will apply.",
        style: PdfUnorderedMarkerStyle.disk,
        font: PdfStandardFont(PdfFontFamily.helvetica, 10,
            style: PdfFontStyle.italic),
        indent: 10,
        textIndent: 10,
        format: PdfStringFormat(lineSpacing: 0));
    PdfTextElement textElement10 = PdfTextElement(
        text: "DRHS STUDENT SIGNATURE:",
        font: PdfStandardFont(PdfFontFamily.helvetica, 11,
            style: PdfFontStyle.bold));
    PdfTextElement textElement11 = PdfTextElement(
        text: "GUEST NAME (if applicable):",
        font: PdfStandardFont(PdfFontFamily.helvetica, 11,
            style: PdfFontStyle.bold));
    PdfTextElement textElement12 = PdfTextElement(
        text: "__${guestName}__",
        font: PdfStandardFont(PdfFontFamily.helvetica, 11,
            style: PdfFontStyle.bold));

    double prevBottom;

    prevBottom = getBottom(textElement.draw(
        page: page,
        bounds: Rect.fromLTWH(
            0, 0, page.getClientSize().width, page.getClientSize().height),
        format: layoutFormat)!);

    prevBottom = getBottom(textElement2.draw(
        page: page,
        bounds: Rect.fromLTWH(0, prevBottom + 12, page.getClientSize().width,
            page.getClientSize().height),
        format: layoutFormat)!);

    prevBottom = getBottom(textElement3.draw(
        page: page,
        bounds: Rect.fromLTWH(0, prevBottom + 12, page.getClientSize().width,
            page.getClientSize().height),
        format: layoutFormat)!);

    prevBottom = getBottom(textElement4.draw(
        page: page,
        bounds: Rect.fromLTWH(0, prevBottom + 10, page.getClientSize().width,
            page.getClientSize().height),
        format: layoutFormat)!);

    prevBottom = getBottom(bullets1.draw(
        page: page,
        bounds: Rect.fromLTWH(0, prevBottom, page.getClientSize().width,
            page.getClientSize().height),
        format: layoutFormat)!);

    prevBottom = getBottom(textElement5.draw(
        page: page,
        bounds: Rect.fromLTWH(0, prevBottom + 10, page.getClientSize().width,
            page.getClientSize().height),
        format: layoutFormat)!);

    prevBottom = getBottom(bullets2.draw(
        page: page,
        bounds: Rect.fromLTWH(0, prevBottom, page.getClientSize().width,
            page.getClientSize().height),
        format: layoutFormat)!);

    prevBottom = getBottom(textElement6.draw(
        page: page,
        bounds: Rect.fromLTWH(0, prevBottom + 10, page.getClientSize().width,
            page.getClientSize().height),
        format: layoutFormat)!);

    prevBottom = getBottom(bullets3.draw(
        page: page,
        bounds: Rect.fromLTWH(0, prevBottom, page.getClientSize().width,
            page.getClientSize().height),
        format: layoutFormat)!);

    prevBottom = getBottom(textElement7.draw(
        page: page,
        bounds: Rect.fromLTWH(0, prevBottom + 10, page.getClientSize().width,
            page.getClientSize().height),
        format: layoutFormat)!);

    prevBottom = getBottom(bullets4.draw(
        page: page,
        bounds: Rect.fromLTWH(0, prevBottom, page.getClientSize().width,
            page.getClientSize().height),
        format: layoutFormat)!);

    prevBottom = getBottom(textElement8.draw(
        page: page,
        bounds: Rect.fromLTWH(0, prevBottom + 10, page.getClientSize().width,
            page.getClientSize().height),
        format: layoutFormat)!);

    prevBottom = getBottom(textElement9.draw(
        page: page,
        bounds: Rect.fromLTWH(0, prevBottom, page.getClientSize().width,
            page.getClientSize().height),
        format: layoutFormat)!);

    prevBottom = getBottom(bullets5.draw(
        page: page,
        bounds: Rect.fromLTWH(0, prevBottom, page.getClientSize().width,
            page.getClientSize().height),
        format: layoutFormat)!);

    textElement10.draw(
        page: page,
        bounds: Rect.fromLTWH(0, prevBottom + 15, page.getClientSize().width,
            page.getClientSize().height),
        format: layoutFormat);

    prevBottom = getBottom(textElement11.draw(
        page: page,
        bounds: Rect.fromLTWH(page.getClientSize().width / 2, prevBottom + 15,
            page.getClientSize().width, page.getClientSize().height),
        format: layoutFormat)!);

    page.graphics.drawImage(
        PdfBitmap(signData!), Rect.fromLTWH(0, prevBottom + 5, 90, 30));

    textElement12.draw(
        page: page,
        bounds: Rect.fromLTWH(page.getClientSize().width / 2, prevBottom + 5,
            page.getClientSize().width, page.getClientSize().height),
        format: layoutFormat);

    List<int> bytes = await document.save();
    document.dispose();

    saveAndLaunchFile(
        bytes, name.replaceAll(" ", "").trim().toLowerCase() + '.pdf');
  }
}

Future<Uint8List> _readImageData(String name) async {
  final data = await rootBundle.load('images/$name');
  return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
}
