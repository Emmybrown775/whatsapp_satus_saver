import 'dart:io';

import 'package:flutter/material.dart';

import 'package:whatsapp_status_saver/const/const.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whatsapp_status_saver/pages/image_page.dart';
import 'package:whatsapp_status_saver/pages/video_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
PageController pageController = PageController();
final Directory _photoDir = Directory('/storage/emulated/0/Android/media/com.'
    'whatsapp/WhatsApp/Media/.Statuses');

askPermission() async {
  await Permission.storage.request();
  await Permission.manageExternalStorage.request();
}


class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {

    askPermission();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var imageList = _photoDir
        .listSync()
        .map((item) => item.path)
        .where((item) => item.endsWith(".jpg"))
        .toList(growable: false);

    var videoList = _photoDir
        .listSync()
        .map((item) => item.path)
        .where((item) => item.endsWith(".mp4"))
        .toList(growable: false);



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
      body: Column(
        children: [
          Container(
            color: main_color,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(83, 24, 83, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Images",
                        style:TextStyle(
                          fontFamily: "PoetsenOne",
                          fontSize: 16,
                          color: Colors.white
                        )
                      ),
                      Text("Videos",
                          style:TextStyle(
                              fontFamily: "PoetsenOne",
                              fontSize: 16,
                            color: Colors.white
                          )
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SmoothPageIndicator(
                      controller: pageController,
                      count: 2,
                    effect: const WormEffect(
                      dotHeight: 5,
                      dotWidth: 112,
                      spacing: 68,
                      dotColor: main_color,
                      activeDotColor: Colors.white
                    ),

                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: PageView(
              controller: pageController,
              children: [
                ImagePage(imagePath: imageList),
                VideoPage(videoPath: videoList)

              ],
            ),
          )
        ],
      )

    );
  }
}
