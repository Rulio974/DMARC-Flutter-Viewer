import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'const_var.dart';
import 'url_path_private.dart';

Future<bool?> uploadFile() async {
  // Sélectionner le fichier
  FilePickerResult? result =
      await FilePicker.platform.pickFiles(withData: true);

  if (result == null) {}

  if (result != null) {
    Uint8List fileBytes = result.files.single.bytes!;
    String fileName = result.files.single.name;

    // Préparez le MultipartFile
    http.MultipartFile multipartFile = http.MultipartFile.fromBytes(
      'file',
      fileBytes,
      filename: fileName,
      contentType: MediaType('application', 'octet-stream'),
    );

    // Créez la requête MultipartRequest
    var request = http.MultipartRequest('POST', url.resolve("/upload"));

    request.files.add(multipartFile);

    var response = await request.send();

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
  return null;
}
