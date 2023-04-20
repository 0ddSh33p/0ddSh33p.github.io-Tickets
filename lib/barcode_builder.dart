import 'dart:core';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;

import 'package:barcode_image/barcode_image.dart';
// ignore: depend_on_referenced_packages
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';

Future<Image> buildBarcode(
  String data, {
  String? filename,
  double? width,
  int? height,
  double? fontHeight,
}) async {
  String url =
      'https://www.lisd.net/cms/lib/TX01918037/Centricity/Domain/4/tchs-homecoming-pep-rally-227.jpg';

  var response = await http.get(Uri.parse(url));
  Directory documentDirectory = await getApplicationDocumentsDirectory();
  File file = File(path.join(documentDirectory.path, path.basename(url)));

  await file.writeAsBytes(response.bodyBytes);

  //create an image file
  final ticket = img.Image(400, 1200);
  img.Image? empyTicket;

  if (url.substring(url.length - 3) == "png") {
    empyTicket = img.decodePng(file.readAsBytesSync());
  } else {
    empyTicket = img.decodeJpg(file.readAsBytesSync());
  }

  img.fill(ticket, img.getColor(255, 255, 255));

  img.drawImage(ticket, empyTicket as img.Image, dstY: 150);

  // Draw the barcode
  drawBarcode(ticket, Barcode.code128(), data,
      height: height, font: img.arial_24);
  File('Images/' '$filename.png').writeAsBytesSync(img.encodePng(ticket));

  return Image.network(url);
}
