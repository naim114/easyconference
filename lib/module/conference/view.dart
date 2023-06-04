import 'dart:convert';

import 'package:easyconference/model/conference_model.dart';
import 'package:easyconference/module/conference/edit.dart';
import 'package:easyconference/service/conference_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../../model/user_model.dart';
import '../../service/helpers.dart';
import '../../service/user_service.dart';

class ConferenceView extends StatelessWidget {
  const ConferenceView({super.key, required this.conference});

  final ConferenceModel conference;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          FutureBuilder<List<UserModel>>(
              future: UserService().getAllPresenter(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox();
                }

                return snapshot.data == null
                    ? const SizedBox()
                    : IconButton(
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ConferenceEdit(
                              presenters: snapshot.data!,
                              conference: conference,
                            ),
                          ),
                        ),
                        icon: const Icon(Icons.edit),
                      );
              }),
          IconButton(
            onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title:
                    const Text('Are you sure you want to delete this session?'),
                content: const Text(
                    'Deleted data can\'t be retrieve back. Select OK to delete.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: CupertinoColors.systemGrey,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final result =
                          await ConferenceService().delete(conference);

                      if (context.mounted) {
                        if (result) {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Fluttertoast.showToast(msg: "Conference deleted!");
                          Fluttertoast.showToast(
                              msg:
                                  "Swipe down to refresh if there is no changes");
                        }
                      }
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(color: CustomColor.danger),
                    ),
                  ),
                ],
              ),
            ),
            icon: const Icon(Icons.delete_forever),
          ),
        ],
      ),
      body: ListView(
        children: [
          conference.posterBytes == null
              ? Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/image/noimage.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                )
              : Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: MemoryImage(base64Decode(conference.posterBytes!)),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
          // Details
          Padding(
            padding: const EdgeInsets.only(
              left: 30,
              right: 30,
              top: 30,
              bottom: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  conference.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  DateFormat("dd/MM/yyyy hh:mm a").format(conference.dateTime),
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 20),
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                          text: "Presenter: ",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: conference.presenter.name),
                    ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                          text: "Specialize: ",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: conference.presenter.specializeArea!.area),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(conference.desc)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
