import 'package:flutter/material.dart';

class FormTemplate extends StatefulWidget {
  final Widget child;

  const FormTemplate({super.key, required this.child});

  @override
  State<FormTemplate> createState() => _FormTemplateState();
}

class _FormTemplateState extends State<FormTemplate> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(key: _formKey, child: widget.child);
  }
}
