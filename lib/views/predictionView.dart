import 'package:flutter/material.dart';

class PredictionView extends StatelessWidget {
  final String string;

  const PredictionView({Key key, this.string}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Text(
        prediction(string),
        textAlign: TextAlign.center,
        textScaleFactor: 1.4,
      ),
    );
  }

  prediction(String image) {
    return "Prediction : " + image;
  }
}
