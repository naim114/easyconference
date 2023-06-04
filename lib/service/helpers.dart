import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

class CustomColor {
  static const primary = Color(0xFF4ad0ee);
  static const bg = Color(0xFF04103a);
  static const light = Color(0xFF101c42);
  static const neutral1 = Color(0xFF1C1243);
  static const neutral2 = Color(0xFFA29EB6);
  static const neutral3 = Color(0xFFEFF1F3);
  static const danger = Color(0xFFFE4A49);
  static const success = Color(0xFF47C272);
}

const List<String> roles = <String>[
  'Participant',
  'Presenter',
  'Reviewer',
  'Judges',
];

const List<String> specialize = [
  'Artificial Intelligence',
  'Data Mining',
  'Computer Security',
  'Internet of Things',
  'Software Engineering',
];

Uint8List imageToBytes(File imageFile) {
  final bytes = imageFile.readAsBytesSync();
  return Uint8List.fromList(bytes);
}

bool validateEmail(String email) {
  const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
  final regex = RegExp(pattern);

  return regex.hasMatch(email);
}
