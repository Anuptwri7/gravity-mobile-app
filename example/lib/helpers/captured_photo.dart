import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
File imageFile;

void showImageDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Please choose an option"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  _getFromCamera(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.camera,
                        color: Colors.purple,
                      ),
                    ),
                    Text(
                      "Camera",
                      style: TextStyle(color: Colors.purple),
                    )
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  _getFromGallery(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.image,
                        color: Colors.purple,
                      ),
                    ),
                    Text(
                      "gallery",
                      style: TextStyle(color: Colors.purple),
                    ),

                  ],
                ),
              ),
            ],
          ),
        );
      });
}

void _getFromGallery(context) async {
  File pickedFile = await ImagePicker.pickImage(
    source: ImageSource.gallery,
    maxHeight: 1080,
    maxWidth: 1080,
  );
  // setState(() {
  imageFile = File(pickedFile.path);
  // });

  log(base64Encode(imageFile.readAsBytesSync()));
  Navigator.pop(context);
}

void _getFromCamera(context) async {
  File pickedFile = await ImagePicker.pickImage(
    source: ImageSource.camera,
    maxHeight: 1080,
    maxWidth: 1080,
  );
  // setState(() {
  imageFile = File(pickedFile.path);
  // log(base64Encode(imageFile!.readAsBytesSync()));
  // });
  Navigator.pop(context);
}
