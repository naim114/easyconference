import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:easyconference/module/account/index.dart';
import 'package:easyconference/module/presenter/index.dart';
import 'package:easyconference/module/profile/index.dart';
import 'package:easyconference/module/session/index.dart';
import 'package:easyconference/service/helpers.dart';
import 'package:flutter/material.dart';

import 'home/index.dart';

class Frame extends StatefulWidget {
  const Frame({super.key});

  @override
  State<Frame> createState() => _FrameState();
}

class _FrameState extends State<Frame> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: CustomColor.bg,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              margin: EdgeInsets.all(0),
              child: Text(
                "EasyConference",
                style: TextStyle(
                  color: CustomColor.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              title: const Text('Account'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Account(),
                ),
              ),
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Profile(),
                ),
              ),
            ),
            ListTile(
              title: const Text(
                'Logout',
                style: TextStyle(color: CustomColor.danger),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Builder(builder: (context) {
          String title = "Presenter List";
          switch (_selectedIndex) {
            case 0:
              title = "Presenter List";
              break;
            case 1:
              title = "Home";
              break;
            case 2:
              title = "Session List";
              break;
            default:
          }
          return Text(title);
        }),
      ),
      body: selectedScreen(context: context, selectedIndex: _selectedIndex),
      bottomNavigationBar: ConvexAppBar(
        style: TabStyle.react,
        items: const [
          TabItem(
            icon: Icons.people,
            title: 'Presenters',
          ),
          TabItem(
            icon: Icons.home,
            title: 'Home',
          ),
          TabItem(
            icon: Icons.calendar_month,
            title: 'Sessions',
          ),
        ],
        initialActiveIndex: 1,
        onTap: (int i) => setState(() => _selectedIndex = i),
      ),
    );
  }

  Widget selectedScreen({
    required BuildContext context,
    required int selectedIndex,
  }) {
    List<Widget> screens = <Widget>[
      Presenter(
        mainContext: context,
      ),
      Home(),
      Session(
        mainContext: context,
      ),
    ];

    return screens.elementAt(selectedIndex);
  }
}
