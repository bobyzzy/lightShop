import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HeaderRow extends StatefulWidget {
  HeaderRow({super.key, required this.onHeaderDataChanged});
  final Function(bool, String) onHeaderDataChanged;

  @override
  State<HeaderRow> createState() => _HeaderRowState();
}

class _HeaderRowState extends State<HeaderRow> {
  bool _isChecked = false;
  void updateHeaderData(bool newData, String metr) {
    widget.onHeaderDataChanged(newData, metr);
  }

  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 1,
          child: Row(
            children: [
              const Text('Введите периметр вашей крыши:'),
              const SizedBox(width: 10),
              TextField(
                controller: _textEditingController,
                maxLength: 3,
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                ],
                decoration: InputDecoration(
                  constraints:
                      const BoxConstraints(maxHeight: 30, maxWidth: 80),
                  contentPadding: const EdgeInsets.symmetric(vertical: 8),
                  counterText: '',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Row(
              children: [
                const Text('Мне нужен монтаж'),
                Checkbox(
                  value: _isChecked,
                  onChanged: (value) {
                    setState(() {
                      _isChecked = value!;
                    });
                    updateHeaderData(value!, _textEditingController.text);
                  },
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
