import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

Future<String?> uploadImageToFirebase(File file) async {
  var task = await FirebaseStorage.instance
      .ref('uploads/${file.hashCode}}')
      .putFile(file);
  return task.ref.getDownloadURL();
}
