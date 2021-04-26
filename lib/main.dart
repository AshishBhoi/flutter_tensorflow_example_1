import 'package:flutter/material.dart';
import 'package:tensorflow_yolo2_example/pages/tfLitePredictPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TfLitePredictPage(),
    );
  }
}
