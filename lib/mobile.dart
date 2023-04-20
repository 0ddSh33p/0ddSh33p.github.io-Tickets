// Code will be changed to instead send pdf to database (hopefully!)
// Here's link to Youtube video to make API call sending PDF file to database: https://www.youtube.com/watch?v=g834QMAqP0s
// *The person in the video uses the Dio package, which is essentially akin to the HTTP package. I think you can do the same thing with HTTP with Multipart File, though I'm uncertain

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
  final path = (await getExternalStorageDirectory())!.path;
  final file = File('$path/$fileName');
  await file.writeAsBytes(bytes, flush: true);
  OpenFile.open('$path/$fileName');
}
