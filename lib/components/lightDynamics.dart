import 'package:flutter/material.dart';

class LightDynamic extends StatefulWidget {
  LightDynamic({super.key,required this.callBack});
  Function(String string)? callBack;
  @override
  State<LightDynamic> createState() => _LightDynamicState();
}

class _LightDynamicState extends State<LightDynamic> {
  int? dropdownValue = 0;
  List<String> text = ['Статика', 'Мерцание'];

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
      items: [0, 1].map<DropdownMenuItem<int>>((e) {
        return DropdownMenuItem<int>(
          value: e,
          child: Text(text[e]),
        );
      }).toList(),
    );
  }
}
