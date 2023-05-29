import 'dart:convert';

import 'package:flutter/material.dart';

import '../../model/user_model.dart';
import '../conference/view.dart';

class PresenterView extends StatelessWidget {
  final UserModel presenter;
  const PresenterView({super.key, required this.presenter});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          // Avatar
          presenter.avatarBytes == null
              ? Container(
                  height: MediaQuery.of(context).size.height * 0.17,
                  width: MediaQuery.of(context).size.width * 0.17,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/image/default-profile-picture.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                )
              : Container(
                  height: MediaQuery.of(context).size.height * 0.17,
                  width: MediaQuery.of(context).size.width * 0.17,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: MemoryImage(base64Decode(presenter.avatarBytes!)),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
          // Name
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
                  presenter.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  presenter.specializeArea!.area,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          // Sessions TODO
          const Divider(),
          // InkWell(
          //   onTap: () => Navigator.of(context).push(MaterialPageRoute(
          //     builder: (context) => ConferenceView(),
          //   )),
          //   child: ListTile(
          //     title: Text(
          //       "Session Name",
          //       style: TextStyle(fontWeight: FontWeight.bold),
          //     ),
          //     trailing: Text("16/3/2023"),
          //   ),
          // ),
        ],
      ),
    );
  }
}
