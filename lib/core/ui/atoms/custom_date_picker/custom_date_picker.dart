import 'package:double_v_partners/core/ui/atoms/custom_text_form_field/custom_text_form_field.dart';
import 'package:double_v_partners/utils/format_date_human.dart';
import 'package:flutter/material.dart';

class CustomDatePicker extends StatefulWidget {
  final Function(DateTime?)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  const CustomDatePicker({
    super.key,
    this.onChanged,
    this.validator,
    this.controller,
  });

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime? selectedDate;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
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
    } else {
      _controller.text = "Selecciona una fecha";
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
          validator: widget.validator,
        ),
      ],
    );
  }
}
