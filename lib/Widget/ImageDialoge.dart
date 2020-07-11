import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageDialog extends StatelessWidget {
  String Image;
  ImageDialog(this.Image);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: MediaQuery.of(context).size.width-10,
        height: MediaQuery.of(context).size.height-300,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: ExactAssetImage('assets/images/profile.png'),
                fit: BoxFit.cover
            )
        ),
      ),
    );
  }
}