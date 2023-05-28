import 'package:flutter/material.dart';

import '../service/helpers.dart';

PreferredSizeWidget appBarConfirmCancel({
  String title = "",
  required void Function() onCancel,
  required void Function() onConfirm,
  required BuildContext context,
}) =>
    AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: onCancel,
        icon: const Icon(
          Icons.close,
          color: CustomColor.neutral2,
        ),
      ),
      actions: [
        IconButton(
          onPressed: onConfirm,
          icon: const Icon(
            Icons.check_outlined,
            color: CustomColor.primary,
          ),
        ),
      ],
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
