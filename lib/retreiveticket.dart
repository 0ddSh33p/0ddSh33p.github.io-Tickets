import 'package:flutter/material.dart';
import 'dart:core';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

import 'package:barcode_image/barcode_image.dart';
// ignore: depend_on_referenced_packages
import 'package:image/image.dart' as img;
import 'package:barcode_widget/barcode_widget.dart';

// ignore: must_be_immutable
class _RetrivalState extends State<Retrival> {
  @override
  void initState() {
    super.initState();
    // ignore: prefer_const_constructors
    // _imageToShow = AssetImage('Bg.png');
  }

  //make the data the api call, and the scr, the image for the ticket's url.
  String data = 'beansandsoup';
  String scr =
      'https://cdn.shopify.com/s/files/1/0406/8413/products/Kona-Kona-Cotton-Acid-Lime-860-gather-here-online_grande.jpg?v=1645541656';

  //create the page with a barcode and ticket image in a colum, this is the usrers ticket
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Big Ticket'),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: Container(
              color: const Color.fromARGB(0, 230, 230, 230),
              child: Column(
                children: [
                  const SizedBox(height: 90),
                  BarcodeWidget(
                    barcode: Barcode.pdf417(),
                    data: data,
                    width: 300,
                    height: 50,
                  ),
                  Image.network(scr, width: 300),
                ],
              ),
            )),
      ),
    );
  }

  //Future<void> callBarcode() async {
  //  _imageToShow = AssetImage(await buildBarcode('data'));
  //  setState(() {});
  // }

  State<Retrival> createState() => _RetrivalState();
}

class Retrival extends StatefulWidget {
  const Retrival({super.key});

  @override
  State<Retrival> createState() => _RetrivalState();
}
