
import 'package:flutter/material.dart';

class Space extends StatelessWidget {
  
  double hEight;

  Space(this.hEight);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: hEight,
    );
  }
}