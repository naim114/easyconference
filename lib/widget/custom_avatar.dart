import 'dart:convert';

import 'package:easyconference/model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget customAvatar({
  double width = 40,
  double height = 40,
  required UserModel user,
}) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      image: user.avatarBytes == null
          ? const DecorationImage(
              image: AssetImage('assets/image/default-profile-picture.png'),
              fit: BoxFit.contain)
          : DecorationImage(
              image: MemoryImage(base64Decode(user.avatarBytes!)),
              fit: BoxFit.fill,
            ),
    ),
  );
}
