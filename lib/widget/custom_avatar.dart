import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget customAvatar({
  String path = 'assets/image/default-profile-picture.png',
  double width = 40,
  double height = 40,
}) {
  return SizedBox(
    height: height,
    width: width,
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(image: AssetImage(path), fit: BoxFit.cover),
      ),
    ),
  );
}
