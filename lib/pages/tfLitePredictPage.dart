import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tensorflow_yolo2_example/views/imageView.dart';
import 'package:tensorflow_yolo2_example/views/predictionView.dart';
import 'package:tflite/tflite.dart';

class TfLitePredictPage extends StatefulWidget {
  @override
  _TfLitePredictPageState createState() => _TfLitePredictPageState();
}

class _TfLitePredictPageState extends State<TfLitePredictPage> {
  bool _loading = true;
  File image;
  final picker = ImagePicker();
  List _output;

  @override
  void initState() {
    super.initState();

    loadModel().then((value) {
      setState(() {});
    });
  }

  detectImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path
    );

    setState(() {
      _output = output;
      _loading = false;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/tflite/model_unquant.tflite",
      labels: "assets/tflite/labels.txt",
    );
  }

  @override
  void dispose() {
    super.dispose();
    Tflite.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TFLite Demo"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _loading ? PredictionView (
              string: "No Inputs",
            )
            : PredictionView(
              string: _output != null
                  ? '${_output[0]['label']}'
                  : "no Prediction",
            ),
            SizedBox(
              height: 20,
            ),
            ImageView(
              image: image,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: getImageFromCamera,
                    child: Row(
                      children: [
                        Icon(
                          Icons.camera,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "Camera",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.black54),
                    ),
                  ),
                  TextButton(
                    onPressed: getImageFromGallery,
                    child: Row(
                      children: [
                        Icon(
                          Icons.image,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          "Gallery",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.black54),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    if(pickedFile == null) return null;

    setState(() {
      image = File(pickedFile.path);
    });

    detectImage(image);
  }

  getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if(pickedFile == null) return null;


    setState(() {
      image = File(pickedFile.path);
    });

    detectImage(image);
  }
}
