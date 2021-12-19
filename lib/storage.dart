import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class Storage {
  final FirebaseStorage store = FirebaseStorage.instance;
  Future<void> uploadFile(
    String filepath,
    String filename,
  ) async {
    File file = File(filepath);
    try {
      await store.ref('test/$filename').putFile(file);
    } on FirebaseException catch (e) {
      print(e);
    }
  }
}
