import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;


import '../const/const.dart';

class ViewImage extends StatefulWidget {
  String path;
  ViewImage({required this.path, Key? key}) : super(key: key);

  @override
  State<ViewImage> createState() => _ViewImageState();
}

class _ViewImageState extends State<ViewImage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: main_color,
        title: const Text("Status Saver",
          style: TextStyle(
            fontFamily: "PoetsenOne",
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.whatsapp),
          )
        ],
        elevation: 0,
      ),
      body: Center(
          child: Image.file(
              File(widget.path),
            height: height,
            width: width,
            fit: BoxFit.contain,
          )) ,
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
          var basNameWithExtension = path.basename(widget.path);
          String newPath = "/storage/emulated/0/Status Saver";
          var file =  await moveFile(File(widget.path),"$newPath/$basNameWithExtension");
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Your file has been saved to $file"))
          );
        },
        backgroundColor: main_color,
        child: const Icon(Icons.download),
      ),
    );
  }
  Future<File> moveFile(File sourceFile, String newPath) async {
    try {
      /// prefer using rename as it is probably faster
      /// if same directory path
      const folderName = "Status Saver";
      final path = Directory("storage/emulated/0/$folderName");
      if ((await path.exists())) {
        return await sourceFile.rename(newPath);
      } else {
        path.create();
        return await sourceFile.rename(newPath);
      }
    } catch (e) {

      /// if rename fails, copy the source file
      final newFile = await sourceFile.copy(newPath);
      return newFile;
    }
  }
}
