import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:easyconference/model/user_model.dart';
import 'package:easyconference/module/account/index.dart';
import 'package:easyconference/module/presenter/index.dart';
import 'package:easyconference/module/profile/index.dart';
import 'package:easyconference/service/auth_service.dart';
import 'package:easyconference/service/helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'auth/wrapper.dart';
import 'conference/index.dart';

class Frame extends StatefulWidget {
  const Frame({super.key, required this.user});

  final UserModel user;

  @override
  State<Frame> createState() => _FrameState();
}

class _FrameState extends State<Frame> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Provider<UserModel>(
      create: (_) => widget.user,
      child: Scaffold(
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
                    builder: (context) => Profile(user: widget.user),
                  ),
                ),
              ),
              ListTile(
                title: const Text(
                  'Logout',
                  style: TextStyle(color: CustomColor.danger),
                ),
                onTap: () async {
                  final logout = await AuthService().logOut();

                  print("logout: $logout");

                  if (context.mounted) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AuthWrapper(),
                      ),
                      (route) => false,
                    );
                  }
                },
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
              icon: Icons.calendar_month,
              title: 'Sessions',
            ),
          ],
          initialActiveIndex: 0,
          onTap: (int i) => setState(() => _selectedIndex = i),
        ),
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
      Conference(
        mainContext: context,
      ),
    ];

    return screens.elementAt(selectedIndex);
  }
}
