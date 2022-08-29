import 'package:flutter/material.dart';

class RadioItem extends StatelessWidget {
  final String value;
  final String gValue;
  final ValueChanged onValueChange;
  final String text;

  const RadioItem({
    Key? key,
    required this.value,
    required this.gValue,
    required this.onValueChange,
    required this.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      value: value,
      groupValue: gValue,
      onChanged: onValueChange,
      title: Text(text),
      contentPadding: const EdgeInsets.only(left: 25, right: 20),
    );
  }
}