import 'package:animate_do/animate_do.dart';
import 'package:double_v_partners/core/ui/atoms/atoms.dart';
import 'package:double_v_partners/core/ui/molecules/molecules.dart';
import 'package:double_v_partners/presentation/providers/new_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PersonalData extends ConsumerStatefulWidget {
  final Function onNextPage;
  final int currentPage;

  const PersonalData({
    super.key,
    required this.onNextPage,
    required this.currentPage,
  });

  @override
  ConsumerState<PersonalData> createState() => _PersonalDataState();
}

class _PersonalDataState extends ConsumerState<PersonalData> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String name = '';
  String lastName = '';
  DateTime? dateOfBirth;

  void _saveUser() {
    ref
        .read(newUserProvider.notifier)
        .updateUser(name: name, lastName: lastName, dateOfBirth: dateOfBirth);
  }

  void _onNextPage() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    _saveUser();

    widget.onNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(newUserProvider);
    name = userData.name;
    lastName = userData.lastName;
    dateOfBirth = userData.dateOfBirth;

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

                  NavigationControls(
                    nextPage: _onNextPage,
                    previousPage: () {},
                    currentPage: widget.currentPage,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
