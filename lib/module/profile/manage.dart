import 'package:easyconference/module/profile/edit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../model/user_model.dart';
import '../../service/helpers.dart';
import '../../service/user_service.dart';
import '../../widget/custom_avatar.dart';
import '../../widget/scaffold_loader.dart';

class ManageUser extends StatefulWidget {
  const ManageUser({super.key});

  @override
  State<ManageUser> createState() => _ManageUserState();
}

class _ManageUserState extends State<ManageUser> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  List<UserModel>? users;
  bool sortAsc = true;

  Future<void> _refreshData() async {
    print("GEEEEEEEEETTTTTTTTTTTTTTTTTTTT");
    try {
      final List<UserModel> fetchedData = await UserService().getAll();

      // sort by latest
      fetchedData.sort((a, b) => a.name.compareTo(b.name));

      setState(() {
        users = fetchedData;
      });

      _refreshIndicatorKey.currentState?.show();
    } catch (e) {
      print("Get User:  ${e.toString()}");
    }

    setState(() {});
  }

  @override
  void initState() {
    _refreshData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _refreshData,
      child: users == null
          ? scaffoldLoader()
          : Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                    onPressed: () {
                      if (users!.length > 1) {
                        if (sortAsc) {
                          // desc
                          setState(() {
                            sortAsc = false;
                            users!.sort((a, b) => b.name.compareTo(a.name));
                          });
                        } else {
                          // asc
                          setState(() {
                            sortAsc = true;
                            users!.sort((a, b) => a.name.compareTo(b.name));
                          });
                        }
                      }
                    },
                    icon: const Icon(Icons.sort_rounded),
                  ),
                ],
              ),
              body: ListView(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    child: Text("Slide user for actions."),
                  ),
                  Column(
                    children: List.generate(
                      users!.length,
                      (index) => InkWell(
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ProfileEdit(
                                      user: users![index],
                                    ))),
                        child: Slidable(
                          key: const ValueKey(0),
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (_) => Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (context) => ProfileEdit(
                                              user: users![index],
                                            ))),
                                backgroundColor: Colors.orange,
                                foregroundColor: Colors.white,
                                icon: Icons.edit,
                                label: 'Edit',
                              ),
                              SlidableAction(
                                onPressed: (_) => showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: Text(
                                        'Are you sure you want to remove ${users![index].name}?'),
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
                                          final result = await UserService()
                                              .delete(users![index]);

                                          if (result) {
                                            Fluttertoast.showToast(
                                                msg: "User deleted!");
                                            Fluttertoast.showToast(
                                                msg:
                                                    "Swipe down to refresh if there is no changes");
                                          }

                                          _refreshData();
                                        },
                                        child: const Text(
                                          'OK',
                                          style: TextStyle(
                                              color: CustomColor.danger),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                backgroundColor: CustomColor.danger,
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                            ],
                          ),
                          child: ListTile(
                            shape: const Border(
                              bottom: BorderSide(
                                color: CustomColor.neutral2,
                              ),
                            ),
                            leading: customAvatar(user: users![index]),
                            title: Text(
                              users![index].name,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              users![index].role,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
