import 'package:animate_do/animate_do.dart';
import 'package:double_v_partners/config/database/data.dart';
import 'package:double_v_partners/core/ui/atoms/atoms.dart';
import 'package:double_v_partners/core/ui/molecules/molecules.dart';
import 'package:flutter/material.dart';

class AddressView extends StatefulWidget {
  final Function onNextPage;
  final Function onPreviousPage;
  final int currentPage;

  const AddressView({
    super.key,
    required this.onNextPage,
    required this.onPreviousPage,
    required this.currentPage,
  });

  @override
  State<AddressView> createState() => _AddressViewState();
}

class _AddressViewState extends State<AddressView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String country = '';
  String department = '';
  String city = '';

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
                  _DropDownCountryCity(),

                  CustomTextFormField(
                    labelText: 'Dirección',
                    hint: 'Ej: C/ San José, 5 #10-12',
                    onChanged: (value) => country = value,
                    prefixIcon: const Icon(Icons.place),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'La dirección es obligatoria';
                      }

                      return null;
                    },
                  ),
                ],
              ),
              NavigationControls(
                nextPage: _onNextPage,
                previousPage: widget.onPreviousPage,
                currentPage: widget.currentPage,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DropDownCountryCity extends StatefulWidget {
  const _DropDownCountryCity();

  @override
  State<_DropDownCountryCity> createState() => _DropDownCountryCityState();
}

class _DropDownCountryCityState extends State<_DropDownCountryCity> {
  String? selectedCountry;
  String? selectedCity;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Dropdown de Países
        DropdownButtonFormField<String>(
          initialValue: selectedCountry,
          decoration: InputDecoration(
            labelText: 'País',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          items: countryCities.keys
              .map(
                (country) =>
                    DropdownMenuItem(value: country, child: Text(country)),
              )
              .toList(),
          onChanged: (value) {
            setState(() {
              selectedCountry = value;
              selectedCity = null; // Reiniciar ciudad
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'El país es obligatorio';
            }
            return null;
          },
        ),

        DropdownButtonFormField<String>(
          initialValue: selectedCity,
          decoration: InputDecoration(
            labelText: 'Ciudad',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          items: selectedCountry == null
              ? []
              : countryCities[selectedCountry]!
                    .map(
                      (city) =>
                          DropdownMenuItem(value: city, child: Text(city)),
                    )
                    .toList(),
          onChanged: (value) {
            setState(() {
              selectedCity = value;
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'La ciudad es obligatoria';
            }
            return null;
          },
        ),
      ],
    );
  }
}
