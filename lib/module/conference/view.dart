import 'package:easyconference/module/conference/edit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../service/helpers.dart';

class ConferenceView extends StatelessWidget {
  const ConferenceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ConferenceEdit(),
              ),
            ),
            icon: const Icon(Icons.edit),
          ),
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
                    onPressed: () {},
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
          // Poster
          SizedBox(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width * 0.25,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/image/noimage.png'),
                  fit: BoxFit.contain,
                ),
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
                  "Session Name",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  "Date and Time",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 20),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: "Presenter: ",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: "Presenter Name"),
                    ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: "Specialize: ",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: "Specialize"),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi ac nisl vitae ante efficitur pretium eu non felis. Cras commodo ex non luctus gravida. Curabitur varius placerat faucibus. Phasellus id lectus dictum, pulvinar justo quis, dapibus urna. Vivamus elementum felis ut orci placerat pulvinar. Sed elit risus, congue et justo quis, aliquet imperdiet ipsum.")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
