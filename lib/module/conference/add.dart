import 'dart:io';

import 'package:easyconference/model/user_model.dart';
import 'package:easyconference/service/conference_service.dart';
import 'package:easyconference/service/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../widget/image_uploader.dart';

class ConferenceAdd extends StatefulWidget {
  const ConferenceAdd({super.key, required this.presenters});

  final List<UserModel> presenters;

  @override
  State<ConferenceAdd> createState() => _ConferenceAddState();
}

class _ConferenceAddState extends State<ConferenceAdd> {
  final nameController = TextEditingController();
  final dateTimeController = TextEditingController();
  final descController = TextEditingController();
  File? poster;

  List<UserModel>? presenters;
  UserModel? presenterDropdownValue;

  @override
  void dispose() {
    nameController.dispose();
    dateTimeController.dispose();
    descController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      presenters = widget.presenters;
      presenterDropdownValue = widget.presenters.first;
    });
  }

  bool validate() {
    if (dateTimeController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Date & time is empty. Please enter all information.");

      return false;
    } else if (nameController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Name is empty. Please enter all information.");

      return false;
    } else if (descController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Description is empty. Please enter all information.");

      return false;
    } else if (presenterDropdownValue == null) {
      Fluttertoast.showToast(msg: "Please select a presenter.");

      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () async {
              if (validate()) {
                print(
                    "poster: ${poster == null ? null : imageToBytes(poster!)}");
                print("presenterDropdownValue: $presenterDropdownValue");

                final result = await ConferenceService().add(
                  name: nameController.text,
                  dateTime: dateTimeController.text,
                  desc: descController.text,
                  posterBytes: poster == null ? null : imageToBytes(poster!),
                  presenter: presenterDropdownValue!,
                );

                if (context.mounted) {
                  if (result) {
                    Navigator.pop(context);
                    Fluttertoast.showToast(msg: "Conference added!");
                  }
                }
              }
            },
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
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ImageUploader(
                      imageFile: poster,
                      appBarTitle: "Upload Poster",
                      onCancel: () => Navigator.of(context).pop(),
                      onConfirm: (imageFile, _) async {
                        setState(() {
                          poster = imageFile;
                        });
                      },
                    ),
                  ),
                ),
                child: poster == null
                    ? Container(
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: MediaQuery.of(context).size.width * 0.25,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/image/noimage.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      )
                    : Image.file(
                        poster!,
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: MediaQuery.of(context).size.width * 0.25,
                        fit: BoxFit.contain,
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
              child: DropdownButtonFormField<UserModel>(
                value: presenterDropdownValue,
                dropdownColor: CupertinoColors.darkBackgroundGray,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  label: Text("Presenter"),
                ),
                onChanged: (UserModel? value) {
                  setState(() {
                    presenterDropdownValue = value!;
                  });
                },
                items: presenters!
                    .map<DropdownMenuItem<UserModel>>((UserModel value) {
                  return DropdownMenuItem<UserModel>(
                    value: value,
                    child: Text(
                      value.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: GoogleFonts.jetBrainsMono().fontFamily,
                      ),
                    ),
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
                controller: descController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
