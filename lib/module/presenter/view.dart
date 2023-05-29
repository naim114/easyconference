import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/conference_model.dart';
import '../../model/user_model.dart';
import '../../service/conference_service.dart';
import '../conference/view.dart';

class PresenterView extends StatefulWidget {
  final UserModel presenter;
  const PresenterView({super.key, required this.presenter});

  @override
  State<PresenterView> createState() => _PresenterViewState();
}

class _PresenterViewState extends State<PresenterView> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  List<ConferenceModel>? conferences;

  Future<void> _refreshData() async {
    try {
      final List<ConferenceModel> fetchedData =
          await ConferenceService().getByUser(widget.presenter);

      // sort by latest
      fetchedData.sort((a, b) => b.dateTime.compareTo(a.dateTime));

      setState(() {
        conferences = fetchedData;
      });

      _refreshIndicatorKey.currentState?.show();
    } catch (e) {
      print("Get Data:  ${e.toString()}");
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
      child: Scaffold(
        appBar: AppBar(),
        body: ListView(
          children: [
            // Avatar
            widget.presenter.avatarBytes == null
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
                        image: MemoryImage(
                            base64Decode(widget.presenter.avatarBytes!)),
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
                    widget.presenter.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    widget.presenter.specializeArea!.area,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            // Sessions
            const Divider(),
            conferences == null || conferences!.isEmpty
                ? const SizedBox()
                : Column(
                    children: List.generate(
                      conferences!.length,
                      (index) => InkWell(
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ConferenceView(
                            conference: conferences![index],
                          ),
                        )),
                        child: ListTile(
                          title: Text(
                            conferences![index].name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: Text(DateFormat("dd/MM/yyyy hh:mm a")
                              .format(conferences![index].dateTime)),
                        ),
                      ),
                    ),
                  ),
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
      ),
    );
  }
}
