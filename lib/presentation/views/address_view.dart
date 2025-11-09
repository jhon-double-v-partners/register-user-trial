import 'package:animate_do/animate_do.dart';
import 'package:double_v_partners/config/database/data.dart';
import 'package:double_v_partners/core/ui/atoms/atoms.dart';
import 'package:double_v_partners/core/ui/molecules/molecules.dart';
import 'package:double_v_partners/domain/entities/entities.dart';
import 'package:double_v_partners/presentation/providers/new_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddressView extends ConsumerStatefulWidget {
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
  ConsumerState<AddressView> createState() => _AddressViewState();
}

class _AddressViewState extends ConsumerState<AddressView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<AddressItem> addresses = [AddressItem()];

  void _addAddress() {
    setState(() {
      addresses.add(AddressItem());
    });
  }

  void _removeAddress(int index) {
    if (addresses.length == 1) return;
    setState(() {
      addresses.removeAt(index);
    });
  }

  void _saveUser() {
    ref.read(newUserProvider.notifier).updateUser(addresses: addresses);
  }

  void _onNextPage() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    _saveUser();

    widget.onNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final themeColors = Theme.of(context).colorScheme;

    return FadeIn(
      child: Form(
        key: _formKey,
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 24,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 24,
                        children: [
                          // Lista dinámica de direcciones
                          ...List.generate(addresses.length, (index) {
                            return FadeInUp(
                              from: 14,
                              duration: const Duration(milliseconds: 300),
                              child: Card(
                                color: themeColors.surface,
                                elevation: 2,
                                margin: const EdgeInsets.only(bottom: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    spacing: 8,
                                    children: [
                                      _DropDownCountryCity(
                                        key: ValueKey('address_$index'),
                                        onCountryChanged: (country) {
                                          addresses[index].country = country;
                                        },
                                        onCityChanged: (city) {
                                          addresses[index].city = city;
                                        },
                                      ),
                                      CustomTextFormField(
                                        labelText: 'Dirección',
                                        hint: 'Ej: Calle 10 #12-45',
                                        prefixIcon: const Icon(
                                          Icons.place_outlined,
                                        ),
                                        onChanged: (value) {
                                          addresses[index].address = value;
                                        },
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'La dirección es obligatoria';
                                          }
                                          return null;
                                        },
                                      ),

                                      // Botón eliminar dirección (solo si hay más de una)
                                      if (addresses.length > 1)
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: TextButton.icon(
                                            onPressed: () =>
                                                _removeAddress(index),
                                            icon: const Icon(
                                              Icons.delete_outline,
                                            ),
                                            label: const Text(
                                              'Eliminar dirección',
                                            ),
                                            style: TextButton.styleFrom(
                                              foregroundColor: Colors.redAccent,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),

                          // Botón agregar dirección
                          OutlinedButton.icon(
                            onPressed: _addAddress,
                            icon: const Icon(Icons.add_location_alt_rounded),
                            label: const Text('Agregar otra dirección'),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                            ),
                          ),

                          const SizedBox(height: 32),

                          NavigationControls(
                            nextPage: _onNextPage,
                            previousPage: widget.onPreviousPage,
                            currentPage: widget.currentPage,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _DropDownCountryCity extends StatefulWidget {
  final ValueChanged<String>? onCountryChanged;
  final ValueChanged<String>? onCityChanged;

  const _DropDownCountryCity({
    super.key,
    this.onCountryChanged,
    this.onCityChanged,
  });

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
              selectedCity = null;
            });
            widget.onCountryChanged?.call(value ?? '');
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
            setState(() => selectedCity = value);
            widget.onCityChanged?.call(value ?? '');
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
