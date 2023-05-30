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

  List<UserModel>? presenters;
  bool sortAsc = true;

  Future<void> _refreshData() async {
    try {
      final List<UserModel> fetchedData = await UserService().getAllPresenter();

      // sort by latest
      fetchedData.sort(
          (a, b) => a.specializeArea!.area.compareTo(b.specializeArea!.area));

      setState(() {
        presenters = fetchedData;
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
      child: presenters == null
          ? scaffoldLoader()
          : Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                actions: [
                  IconButton(
                    onPressed: () {
                      if (presenters!.length > 1) {
                        if (sortAsc) {
                          // desc
                          setState(() {
                            sortAsc = false;
                            presenters!.sort((a, b) => b.specializeArea!.area
                                .compareTo(a.specializeArea!.area));
                          });
                        } else {
                          // asc
                          setState(() {
                            sortAsc = true;
                            presenters!.sort((a, b) => a.specializeArea!.area
                                .compareTo(b.specializeArea!.area));
                          });
                        }
                      }
                    },
                    icon: const Icon(Icons.sort_rounded),
                  ),
                ],
              ),
              body: ListView(
                children: List.generate(
                  presenters!.length,
                  (index) => InkWell(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PresenterView(
                              presenter: presenters![index],
                            ))),
                    child: ListTile(
                      shape: const Border(
                        bottom: BorderSide(
                          color: CustomColor.neutral2,
                        ),
                      ),
                      leading: customAvatar(user: presenters![index]),
                      title: Text(
                        presenters![index].name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(presenters![index].specializeArea!.area),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
