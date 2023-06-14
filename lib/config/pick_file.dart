import 'dart:io';
import 'package:dmarc_flutter/config/const_var.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'const_var.dart';

void uploadFile() async {
  // Sélectionner le fichier
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    File file = File(result.files.single.path!);

    var request = http.MultipartRequest('POST', url.resolve("/upload"));

    request.files.add(await http.MultipartFile.fromPath('file', file.path));

    var response = await request.send();

    if (response.statusCode == 200) print('Uploaded!');
  }
}
