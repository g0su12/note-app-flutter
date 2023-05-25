import 'package:flutter/material.dart';

class AppDropdownFormField extends StatefulWidget {
  const AppDropdownFormField({Key? key,
    this.icon,
    required this.list,
    required this.onChange,
    this.initialValue})
      : super(key: key);
  final Icon? icon;
  final List<String> list;
  final Function onChange;
  final String? initialValue;

  @override
  State<AppDropdownFormField> createState() => _AppDropdownFormFieldState();
}

class _AppDropdownFormFieldState extends State<AppDropdownFormField> {
  String? _dropdownValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dropdownValue = widget.initialValue ?? widget.list[0];
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        icon: widget.icon ?? const Icon(Icons.category),
      ),
      value: _dropdownValue,
      items: widget.list.map<DropdownMenuItem<String>>(
              (String dropdownValue) {
            return DropdownMenuItem<String>(
              value: dropdownValue,
              child: Text(dropdownValue),
            );
          }).toList(),
      onChanged: (value) {
        setState(() {
          _dropdownValue = value ?? "";
        });
        widget.onChange(value ?? "");
      },
    );
  }
}
