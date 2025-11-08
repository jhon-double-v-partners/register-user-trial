import 'package:double_v_partners/core/ui/atoms/custom_text_form_field/custom_text_form_field.dart';
import 'package:double_v_partners/utils/format_date_human.dart';
import 'package:flutter/material.dart';

class DatePickerExample extends StatefulWidget {
  final Function(DateTime?)? onChanged;

  const DatePickerExample({super.key, this.onChanged});

  @override
  State<DatePickerExample> createState() => _DatePickerExampleState();
}

class _DatePickerExampleState extends State<DatePickerExample> {
  DateTime? selectedDate;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: DateTime(1900),
      lastDate: DateTime(now.year + 1),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;

        _controller.text = formatDateHuman(pickedDate);
      });

      widget.onChanged?.call(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 20,
      children: <Widget>[
        CustomTextFormField(
          labelText: 'Fecha de nacimiento',
          controller: _controller,
          onTap: _selectDate,
          readOnly: true,
          prefixIcon: Icon(Icons.calendar_today),
        ),
      ],
    );
  }
}
