import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  File? file;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
  var imagePicker = ImagePicker();

  uplode() async {
    var image = await imagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      file = File(image.path);
      var nameImage = basename(image.path);
      var storge =
          firebase_storage.FirebaseStorage.instance.ref("images/$nameImage");
      await storge.putFile(file!);
      storge.getDownloadURL();
    } else {
      print("choose image");
    }
  }

  getImage() async {
    var ref = await firebase_storage.FirebaseStorage.instance.ref().list();
    ref.items.forEach((element) {
      print(element.name);
    });
  }

  @override
  void initState() {
    getImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('hh'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              await uplode();
            },
            child: Text("Uplode"),
          ),
        ));
  }
}
