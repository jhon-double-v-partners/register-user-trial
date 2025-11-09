import 'package:animate_do/animate_do.dart';
import 'package:double_v_partners/core/ui/atoms/atoms.dart';
import 'package:double_v_partners/core/ui/molecules/molecules.dart';
import 'package:double_v_partners/presentation/providers/new_user_provider.dart';
import 'package:double_v_partners/utils/format_date_human.dart';
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

  late TextEditingController _nameController;
  late TextEditingController _lastNameController;
  late TextEditingController _dateOfBirthController;
  late DateTime? dateOfBirth;

  @override
  void initState() {
    super.initState();
    final userData = ref.read(newUserProvider);

    _nameController = TextEditingController(text: userData.name);
    _lastNameController = TextEditingController(text: userData.lastName);
    dateOfBirth = userData.dateOfBirth;
    _dateOfBirthController = TextEditingController(
      text: formatDateHuman(userData.dateOfBirth),
    );
  }

  @override
  void dispose() {
    _saveUser();
    _nameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  void _saveUser() {
    ref
        .read(newUserProvider.notifier)
        .updateUser(
          name: _nameController.text,
          lastName: _lastNameController.text,
          dateOfBirth: dateOfBirth,
        );
  }

  void _onNextPage() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) return;

    _saveUser();

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
                    controller: _nameController,
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
                    controller: _lastNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'El apellido es obligatorio';
                      }

                      return null;
                    },
                  ),

                  CustomDatePicker(
                    onChanged: (value) => dateOfBirth = value,
                    controller: _dateOfBirthController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'El fecha es obligatoria';
                      }

                      return null;
                    },
                    initialDate: dateOfBirth,
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
