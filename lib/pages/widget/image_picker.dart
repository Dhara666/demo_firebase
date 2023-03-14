import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerPage extends StatefulWidget {
  const ImagePickerPage({Key? key}) : super(key: key);

  @override
  State<ImagePickerPage> createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {

  final ImagePicker imgpicker = ImagePicker();
  List<XFile>? imagefiles;

  openImages() async {
    try {
      var pickedfiles = await imgpicker.pickMultiImage();
      //you can use ImageCourse.camera for Camera capture
      if(pickedfiles != null){
        imagefiles = pickedfiles;
        setState(() {
        });
      }else{
        print("No image is selected.");
      }
    }catch (e) {
      print("error while picking file.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("Multiple Image Picker Flutter"),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: (){
                    openImages();
                  },
                  child: Text("Open Images")
              ),
              const Divider(),
              const Text("Picked Files:"),
              const Divider(),
              imagefiles != null ?
              Wrap(
                children: imagefiles!.map((imageone){
                  return Container(
                      child:Card(
                        child: Container(
                          height: 100, width:100,
                          child: Image.file(File(imageone.path)),
                        ),
                      )
                  );
                }).toList(),
              ):Container()
            ],
          ),
        )
    );
  }
}
