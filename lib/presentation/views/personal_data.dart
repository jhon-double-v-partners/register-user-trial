import 'package:animate_do/animate_do.dart';
import 'package:double_v_partners/core/ui/atoms/atoms.dart';
import 'package:double_v_partners/core/ui/molecules/molecules.dart';
import 'package:flutter/material.dart';

class PersonalData extends StatefulWidget {
  final Function onNextPage;
  final int currentPage;

  const PersonalData({
    super.key,
    required this.onNextPage,
    required this.currentPage,
  });

  @override
  State<PersonalData> createState() => _PersonalDataState();
}

class _PersonalDataState extends State<PersonalData> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String name = '';
  String lastName = '';
  DateTime? dateOfBirth;

  void _onNextPage() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    widget.onNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: Form(
        key: _formKey,
        child: SizedBox.expand(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 16,
                children: [
                  CustomTextFormField(
                    labelText: 'Nombre',
                    hint: 'Nombre',
                    onChanged: (value) => name = value,
                    prefixIcon: const Icon(Icons.person),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'El nombre es obligatorio';
                      }

                      return null;
                    },
                  ),

                  CustomTextFormField(
                    labelText: 'Apellido',
                    hint: 'Apellido',
                    prefixIcon: Icon(Icons.abc),
                    onChanged: (value) => lastName = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'El apellido es obligatorio';
                      }

                      return null;
                    },
                  ),

                  DatePickerExample(
                    onChanged: (value) => dateOfBirth = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'El fecha es obligatoria';
                      }

                      return null;
                    },
                  ),
                ],
              ),

              NavigationControls(
                nextPage: _onNextPage,
                previousPage: () {},
                currentPage: widget.currentPage,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
