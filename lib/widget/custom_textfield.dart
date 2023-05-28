import 'package:easyconference/service/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.icon,
    required this.labelText,
    this.isPassword = false,
    this.controller,
    this.errorText,
    this.inputFormatters,
  });

  final Icon icon;
  final String labelText;
  final bool isPassword;
  final TextEditingController? controller;
  final String? errorText;
  final List<TextInputFormatter>? inputFormatters;
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  // Initially password is obscure
  bool _obscureText = true;
  Icon _peek = const Icon(CupertinoIcons.eye);

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
      _peek = _obscureText
          ? const Icon(CupertinoIcons.eye)
          : const Icon(CupertinoIcons.eye_fill);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.isPassword
        ? Material(
            elevation: 2,
            borderOnForeground: false,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            child: TextField(
              controller: widget.controller,
              style: const TextStyle(color: CustomColor.neutral1),
              decoration: InputDecoration(
                errorText: widget.errorText,
                errorMaxLines: 2,
                prefixIcon: widget.icon,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                ),
                labelText: widget.labelText,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                suffixIcon: IconButton(
                  icon: _peek,
                  onPressed: _toggle,
                ),
              ),
              obscureText: _obscureText,
              enableSuggestions: false,
              autocorrect: false,
            ),
          )
        : Material(
            elevation: 2,
            borderOnForeground: false,
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            child: TextField(
              controller: widget.controller,
              style: const TextStyle(color: CustomColor.neutral1),
              decoration: InputDecoration(
                prefixIcon: widget.icon,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
                errorText: widget.errorText,
                errorMaxLines: 2,
                labelText: widget.labelText,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                // fillColor: Colors.transparent,
                // filled: true,
              ),
              inputFormatters: widget.inputFormatters,
            ),
          );
  }
}
