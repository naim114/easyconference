import 'package:easyconference/service/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:intl/intl.dart';

class ConferenceEdit extends StatefulWidget {
  const ConferenceEdit({super.key});

  @override
  State<ConferenceEdit> createState() => _ConferenceEditState();
}

// TODO change this to user presenter list
List<String> presenters = <String>['One', 'Two', 'Three', 'Four'];

class _ConferenceEditState extends State<ConferenceEdit> {
  final nameController = TextEditingController();
  final dateTimeController = TextEditingController();
  final descController = TextEditingController();

  String presenterDropdownValue = presenters.first;

  @override
  void dispose() {
    nameController.dispose();
    dateTimeController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              "Confirm",
              style: TextStyle(color: CustomColor.primary),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: ListView(
          children: [
            // Poster
            SizedBox(
              child: InkWell(
                onTap: () => showModalBottomSheet(
                  context: context,
                  backgroundColor: CupertinoColors.darkBackgroundGray,
                  builder: (context) {
                    return Wrap(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.image_outlined),
                          title: const Text('New poster'),
                          onTap: () {},
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.delete_outline,
                            color: CustomColor.danger,
                          ),
                          title: const Text(
                            'Remove current picture',
                            style: TextStyle(color: CustomColor.danger),
                          ),
                          onTap: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text(
                                  'Are you sure you want to remove your poster?'),
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
                        ),
                      ],
                    );
                  },
                ),
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
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 40),
              child: Text(
                "Tap image to change poster",
                textAlign: TextAlign.center,
              ),
            ),
            // Name
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Session Name'),
              ),
            ),
            // Presenter
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: DropdownButtonFormField(
                value: presenterDropdownValue,
                dropdownColor: CupertinoColors.darkBackgroundGray,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  label: Text("Presenter"),
                ),
                onChanged: (String? value) {
                  setState(() {
                    presenterDropdownValue = value!;
                  });
                },
                items: presenters.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            // Date Time
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextField(
                controller: dateTimeController,
                readOnly: true,
                decoration: const InputDecoration(labelText: 'Date & Time'),
                onTap: () {
                  return DatePicker.showDatePicker(
                    context,
                    dateFormat: 'dd MMMM yyyy HH:mm',
                    initialDateTime: DateTime.now(),
                    minDateTime: DateTime.now(),
                    maxDateTime: DateTime(3000),
                    onMonthChangeStartWithFirstDate: true,
                    onConfirm: (dateTime, List<int> index) {
                      DateTime selectdate = dateTime;
                      final selIOS =
                          DateFormat('dd/MM/yyyy hh:mm a').format(selectdate);
                      setState(() => dateTimeController.text = selIOS);
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
