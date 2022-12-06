import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:whatsapp_status_saver/pages/view_image.dart';

class ImagePage extends StatefulWidget {
  List<String> imagePath;

  ImagePage({required this.imagePath, Key? key}) : super(key: key);

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: widget.imagePath.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: 3.0 / 4.6, mainAxisSpacing: 10),
        itemBuilder: (context, index) {
          File file = File(widget.imagePath[index]);
          return GestureDetector(
            onTap: (){
              Navigator.push(context,
                  CupertinoPageRoute(builder: (context) =>
                      ViewImage(path: widget.imagePath[index])
                  ));
            },
              child: Image.file(file)
          );
        });
  }

}
