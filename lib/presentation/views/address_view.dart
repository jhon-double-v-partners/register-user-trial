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
  final List<TextEditingController> _addressControllers = [];

  final List<AddressItem> addresses = [];

  @override
  void initState() {
    final userData = ref.read(newUserProvider);

    if (userData.addresses != null) {
      addresses.addAll(userData.addresses ?? []);
    } else {
      addresses.add(AddressItem());
    }

    for (final address in addresses) {
      _addressControllers.add(TextEditingController(text: address.address));
    }

    super.initState();
  }

  @override
  void dispose() {
    for (final controller in _addressControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addNewAddress() {
    setState(() {
      addresses.add(AddressItem());
      _addressControllers.add(TextEditingController());
    });
  }

  void _removeAddress(int index) {
    if (addresses.length == 1) return;
    setState(() {
      addresses.removeAt(index);
      _addressControllers.removeAt(index).dispose();
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

  void _onPreviousPage() {
    _saveUser();

    widget.onPreviousPage();
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
                        horizontal: 8,
                        vertical: 16,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 16,
                        children: [
                          // Lista dinámica de direcciones
                          ...List.generate(addresses.length, (index) {
                            final address = addresses[index];
                            return FadeInUp(
                              key: ValueKey(address.id),
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
                                        key: ValueKey('dropdown_${address.id}'),
                                        onCountryChanged: (country) {
                                          addresses[index].country = country;
                                        },
                                        onCityChanged: (city) {
                                          addresses[index].city = city;
                                        },
                                        initialCountry: address.country,
                                        initialCity: address.city,
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
                                        controller: _addressControllers[index],
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

                          CustomButton(
                            text: 'Agregar otra dirección',
                            onPressed: _addNewAddress,
                            icon: const Icon(Icons.add_location_alt_rounded),
                          ),

                          const SizedBox(height: 32),

                          NavigationControls(
                            nextPage: _onNextPage,
                            previousPage: _onPreviousPage,
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
  final String? initialCountry;
  final String? initialCity;

  const _DropDownCountryCity({
    super.key,
    this.onCountryChanged,
    this.onCityChanged,
    this.initialCountry,
    this.initialCity,
  });

  @override
  State<_DropDownCountryCity> createState() => _DropDownCountryCityState();
}

class _DropDownCountryCityState extends State<_DropDownCountryCity> {
  String? selectedCountry;
  String? selectedCity;

  @override
  void initState() {
    super.initState();
    selectedCountry = widget.initialCountry;
    selectedCity = widget.initialCity;
  }

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
