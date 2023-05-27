import 'package:easyconference/module/session/view.dart';
import 'package:flutter/material.dart';

class PresenterView extends StatelessWidget {
  const PresenterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          // Avatar
          SizedBox(
            width: MediaQuery.of(context).size.height * 0.17,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.17,
              width: MediaQuery.of(context).size.height * 0.17,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/image/default-profile-picture.png'),
                  fit: BoxFit.contain,
                ),
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
                  "Presenter Name",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  "Expertise",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          // Sessions
          const Divider(),
          InkWell(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SessionView(),
            )),
            child: ListTile(
              title: Text(
                "Session Name",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: Text("16/3/2023"),
            ),
          ),
        ],
      ),
    );
  }
}
