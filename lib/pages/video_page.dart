import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:whatsapp_status_saver/const/const.dart';
import 'package:whatsapp_status_saver/pages/video.dart';

class VideoPage extends StatefulWidget {
  List<String> videoPath;
  VideoPage({required this.videoPath, Key? key}) : super(key: key);

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  Future<Uint8List?> test(path) async{
    var image =  VideoThumbnail.thumbnailData(
      video: path,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 128,
      // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
      quality: 25,
    );
    return image;
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: widget.videoPath.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: 3.0 / 4.6, mainAxisSpacing: 10),
        itemBuilder: (context, index) {
          return FutureBuilder<Uint8List?>(
            future: test(widget.videoPath[index]),
              builder: (context, snapshot){
              if(snapshot.hasData){
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) =>
                        Video(path: widget.videoPath[index])
                    ));
                  },
                  child: Center(
                    child: Stack(
                      children: [
                        Center(child: Image.memory(snapshot.data!)),
                        const Center(child: Icon(Icons.play_arrow, size: 50, color: main_color,)),

                      ],
                    ),
                  ),
                );
              }else{
                return const SizedBox.shrink();
              }
            }
          );
        });
  }
}
