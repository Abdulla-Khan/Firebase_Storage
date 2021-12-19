import 'package:file_picker/file_picker.dart';
import 'package:fire_storage/storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var results;
  Storage storage = Storage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
                onPressed: () async {
                  results = await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ["pdf", "jpg", "png", "jpeg"]);

                  setState(() {
                    results = results;
                  });

                  if (results == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("No Files Selected"),
                    ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("File Added"),
                    ));
                  }
                  final path = results.files.single.path;
                  final file = results.files.single.name;
                  storage.uploadFile(path, file);
                },
                child: const Text("Upload File")),
          ),
          if (results != null)
            Container(
              child: Image.file(File(results.files.single.path)),
            ),
        ],
      ),
    );
  }
}
