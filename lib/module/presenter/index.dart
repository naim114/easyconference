import 'package:easyconference/module/presenter/view.dart';
import 'package:flutter/material.dart';

import '../../model/user_model.dart';
import '../../service/helpers.dart';
import '../../service/user_service.dart';
import '../../widget/custom_avatar.dart';
import '../../widget/scaffold_loader.dart';

class Presenter extends StatefulWidget {
  final BuildContext mainContext;
  const Presenter({
    super.key,
    required this.mainContext,
  });

  @override
  State<Presenter> createState() => _PresenterState();
}

class _PresenterState extends State<Presenter> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  List<UserModel>? users;

  Future<void> _refreshData() async {
    try {
      final List<UserModel> fetchedData = await UserService().getAllPresenter();

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
              body: ListView(
                children: List.generate(
                  users!.length,
                  (index) => InkWell(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PresenterView(
                              presenter: users![index],
                            ))),
                    child: ListTile(
                      shape: const Border(
                        bottom: BorderSide(
                          color: CustomColor.neutral2,
                        ),
                      ),
                      leading: customAvatar(),
                      title: Text(
                        users![index].name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(users![index].specializeArea!.area),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
