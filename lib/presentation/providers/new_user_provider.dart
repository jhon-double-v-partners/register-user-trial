import 'package:double_v_partners/domain/entities/entities.dart';
import 'package:flutter_riverpod/legacy.dart';

final newUserProvider = StateNotifierProvider<NewUserProvider, NewUser>(
  (ref) => NewUserProvider(),
);

class NewUserProvider extends StateNotifier<NewUser> {
  NewUserProvider() : super(NewUser());

  void updateUser({
    String? name,
    String? lastName,
    DateTime? dateOfBirth,
    String? country,
    String? city,
    List<AddressItem>? addresses,
  }) {
    state = state.copyWith(
      name: name,
      lastName: lastName,
      dateOfBirth: dateOfBirth,
      country: country,
      city: city,
      addresses: addresses,
    );
  }

  void resetUser() {
    state = NewUser();
  }
}

class NewUser {
  final String name;
  final String lastName;
  final DateTime? dateOfBirth;
  final String? country;
  final String? city;
  final List<AddressItem>? addresses;

  const NewUser({
    this.name = '',
    this.lastName = '',
    this.dateOfBirth,
    this.country,
    this.city,
    this.addresses,
  });

  NewUser copyWith({
    int? currentPage,
    String? name,
    String? lastName,
    DateTime? dateOfBirth,
    String? country,
    String? city,
    List<AddressItem>? addresses,
  }) {
    return NewUser(
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      country: country ?? this.country,
      city: city ?? this.city,
      addresses: addresses ?? this.addresses,
    );
  }

  @override
  String toString() {
    return 'NewUser(name: $name, lastName: $lastName, dateOfBirth: $dateOfBirth, country: $country, city: $city, addresses: $addresses)';
  }
}
