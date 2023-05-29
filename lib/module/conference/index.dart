import 'package:easyconference/model/conference_model.dart';
import 'package:easyconference/model/user_model.dart';
import 'package:easyconference/module/conference/add.dart';
import 'package:easyconference/module/conference/view.dart';
import 'package:easyconference/service/conference_service.dart';
import 'package:easyconference/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../service/helpers.dart';
import '../../widget/scaffold_loader.dart';

class Conference extends StatefulWidget {
  const Conference({super.key, required this.mainContext});
  final BuildContext mainContext;

  @override
  State<Conference> createState() => _ConferenceState();
}

class _ConferenceState extends State<Conference> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  List<ConferenceModel>? conferences;

  Future<void> _refreshData() async {
    try {
      final List<ConferenceModel> fetchedData =
          await ConferenceService().getAll();

      setState(() {
        conferences = fetchedData;
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
      child: conferences == null
          ? scaffoldLoader()
          : Scaffold(
              floatingActionButton: FutureBuilder<List<UserModel>>(
                  future: UserService().getAllPresenter(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox();
                    }

                    return snapshot.data == null
                        ? const SizedBox()
                        : FloatingActionButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ConferenceAdd(
                                    presenters: snapshot.data!,
                                  ),
                                ),
                              );
                            },
                            child: const Icon(Icons.add),
                          );
                  }),
              body: ListView(
                children: List.generate(
                  conferences!.length,
                  (index) => InkWell(
                    onTap: () {
                      Navigator.of(widget.mainContext).push(
                        MaterialPageRoute(
                          builder: (context) => ConferenceView(
                            conference: conferences![index],
                          ),
                        ),
                      );
                    },
                    child: ListTile(
                      shape: const Border(
                        bottom: BorderSide(
                          color: CustomColor.neutral2,
                        ),
                      ),
                      title: Text(
                        conferences![index].name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(DateFormat("dd/MM/yyyy hh:mm a")
                          .format(conferences![index].dateTime)),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
