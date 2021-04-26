import 'dart:io';

import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  final File image;

  const ImageView({Key key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).orientation == Orientation.landscape
            ? MediaQuery.of(context).size.width / 2.5
            : MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).orientation == Orientation.landscape
            ? MediaQuery.of(context).size.height / 2.5
            : MediaQuery.of(context).size.height / 2,
        color: Colors.black26,
        child: image == null
            ? Center(
                child: Text(
                  "No File Selected",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            : Image.file(File(image.path)));
  }
}
