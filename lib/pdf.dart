// Unused file for now

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:open_document/open_document.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';

class PDF {
  Future<Uint8List> makePDF() async {
    final pdf = pw.Document();
    print("yay");
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Text('Yay!'),
        ),
      ),
    );
    print("kdfds");
    //return savePDF(name: 'yay.pdf', pdf: pdf);
    return pdf.save();
    /*final file = File('somePdf.pdf');
    await file.writeAsBytes(await pdf.save());*/
  }

  Future<void> savePDF({required String name, required Uint8List bytes}) async {
    //final bytes = await pdf.save();
    print("Checkpoint 1");
    final output = await getTemporaryDirectory();
    //final direct = await getApplicationDocumentsDirectory();
    print("Checkpoint 2");
    var path = "${output}/$name.pdf";
    final file = File(path);

    await file.writeAsBytes(bytes);
    print("Checkpoint 3");
    await OpenDocument.openDocument(filePath: path);
  }

  static Future openPDF(File file) async {
    print("som");
    await OpenFile.open(file.path);
  }
}
