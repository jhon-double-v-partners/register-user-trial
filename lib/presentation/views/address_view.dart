import 'package:double_v_partners/core/ui/atoms/atoms.dart';
import 'package:double_v_partners/core/ui/template/form_template.dart';
import 'package:flutter/material.dart';

class AddressView extends StatelessWidget {
  const AddressView({super.key});

  @override
  Widget build(BuildContext context) {
    String name = '';
    String lastName = '';
    DateTime? dateOfBirth;

    return FormTemplate(
      child: SizedBox.expand(
        child: Column(
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
            ),

            DatePickerExample(onChanged: (value) => dateOfBirth = value),
          ],
        ),
      ),
    );
  }
}
