import 'package:easyconference/module/conference/edit.dart';
import 'package:easyconference/module/conference/view.dart';
import 'package:flutter/material.dart';

import '../../service/helpers.dart';

class Conference extends StatelessWidget {
  const Conference({super.key, required this.mainContext});
  final BuildContext mainContext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ConferenceEdit(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      body: ListView(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(mainContext).push(
                MaterialPageRoute(
                  builder: (context) => ConferenceView(),
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
