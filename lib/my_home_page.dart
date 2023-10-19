import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _picker = ImagePicker();
  XFile? _file;
  // bu lyubor rasm!
  String _imageUrl = 'https://t4.ftcdn.net/jpg/04/73/25/49/360_F_473254957_bxG9yf4ly7OBO5I0O5KABlN930GwaMQz.jpg';

  void _getImage() async {
    final file = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _file = file;
    });
  }

  void _uploadToStorage() async {
    final path = 'files/${_file?.name ?? "no file"}';
    final file = File(_file?.path ?? "");

    final ref = FirebaseStorage.instance.ref().child(path);
    final response = ref.putFile(file);
    final snapshot = await response.whenComplete(() {
      print('yuklandi');
    });
    _imageUrl = await snapshot.ref.getDownloadURL();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Storage"),
      ),
      body: Column(
        children: [
          _file == null ? const Icon(Icons.image) : Image.file(
              File(_file?.path ?? ""),
            width: double.infinity,
            height: 150,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 30),
          Image.network(_imageUrl, width: double.infinity,
            height: 150,
            fit: BoxFit.cover),
          const SizedBox(height: 30),
          ElevatedButton.icon(onPressed: () {
            _getImage();
          }, icon: Icon(Icons.download), label: Text("Get Image")),
          const SizedBox(height: 10),
          ElevatedButton.icon(onPressed: () {
            _uploadToStorage();
          }, icon: Icon(Icons.upload), label: Text("Upload to Frebase")),
        ],
      ),
    );
  }
}
