import 'package:easyconference/module/presenter/view.dart';
import 'package:flutter/material.dart';

import '../../service/helpers.dart';
import '../../widget/custom_avatar.dart';

class Presenter extends StatelessWidget {
  final BuildContext mainContext;
  const Presenter({
    super.key,
    required this.mainContext,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          InkWell(
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const PresenterView())),
            child: ListTile(
              shape: const Border(
                bottom: BorderSide(
                  color: CustomColor.neutral2,
                ),
              ),
              leading: customAvatar(),
              title: Text(
                "Presenter Name",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Expertise"),
            ),
          ),
        ],
      ),
    );
  }
}
