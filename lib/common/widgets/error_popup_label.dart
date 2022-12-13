import 'package:flutter/material.dart';

class ErrorPopupLabel extends StatelessWidget {
  const ErrorPopupLabel({
    required this.errorText,
    Key? key,
  }) : super(key: key);

  final String errorText;
  @override
  Widget build(BuildContext context) {
    return Text(
      errorText,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.red),
    );
  }
}
