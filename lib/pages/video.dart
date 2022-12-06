import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:whatsapp_status_saver/const/const.dart';
import 'package:path/path.dart' as path;

class Video extends StatefulWidget {
  String path;
  Video({required this.path, Key? key}) : super(key: key);

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {

  VideoPlayerController? _controller;

  @override
  void initState() {
    _controller = VideoPlayerController.file(File(widget.path))..initialize().
    then((value) {
      setState(() {

      });
    });
    _controller!.play();
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    _controller!.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
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
      body: GestureDetector(
        onTap: (){
          setState(() {
            if(_controller!.value.isPlaying){

              _controller!.pause();
            }else{
              _controller!.play();
            }
          });

        },
          child: Center(
            child: AspectRatio(
              aspectRatio: _controller!.value.aspectRatio,
                child: VideoPlayer(_controller!)),
          )
      ),
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