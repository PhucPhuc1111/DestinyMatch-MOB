import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateOfBirthField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final String icon;
  final String? Function(String?)? validator;

  const DateOfBirthField({
    required this.textEditingController,
    required this.hintText,
    required this.icon,
    this.validator,
    super.key,
  });

  @override
  _DateOfBirthFieldState createState() => _DateOfBirthFieldState();
}

class _DateOfBirthFieldState extends State<DateOfBirthField> {
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');
  String _dateOfBirth = '00/00/0000';

  @override
  void initState() {
    super.initState();
    widget.textEditingController.text = _dateOfBirth;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: now,
    );

    if (picked != null && picked != now) {
      setState(() {
        _dateOfBirth = _dateFormat.format(picked);
        widget.textEditingController.text = _dateOfBirth;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      readOnly: true,
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Image.asset(widget.icon, height: 20, width: 20),
        ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: () => _selectDate(context),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: widget.validator,
    );
  }
}
