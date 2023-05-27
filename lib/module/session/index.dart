import 'package:easyconference/module/session/view.dart';
import 'package:flutter/material.dart';

import '../../service/helpers.dart';

class Session extends StatelessWidget {
  const Session({super.key, required this.mainContext});
  final BuildContext mainContext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(mainContext).push(
                MaterialPageRoute(
                  builder: (context) => SessionView(),
                ),
              );
            },
            child: ListTile(
              shape: const Border(
                bottom: BorderSide(
                  color: CustomColor.neutral2,
                ),
              ),
              title: Text(
                "Session Name",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Date Time"),
            ),
          ),
        ],
      ),
    );
  }
}
