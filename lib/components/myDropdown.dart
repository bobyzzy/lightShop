import 'package:flutter/material.dart';

class MyDropdown extends StatefulWidget {
  MyDropdown({super.key, required this.callBack});

  Function(String string)? callBack;
  @override
  State<MyDropdown> createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
  int? dropdownValue = 0;
  List<Icon> icons = [
    const Icon(Icons.lightbulb_outline),
    const Icon(Icons.lightbulb, color: Colors.blue),
    const Icon(Icons.lightbulb, color: Colors.yellow),
    const Icon(Icons.lightbulb, color: Colors.red),
  ];

  void _changeValue(value) {
    setState(() {
      dropdownValue = value;
      if (widget.callBack != null) {
        widget.callBack!(dropdownValue.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      value: dropdownValue,
      onChanged: _changeValue,
      items: [0, 1, 2, 3].map<DropdownMenuItem<int>>((e) {
        return DropdownMenuItem<int>(
          value: e,
          child: icons[e],
        );
      }).toList(),
    );
  }
}
