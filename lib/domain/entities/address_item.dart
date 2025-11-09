class AddressItem {
  final String id;
  String? country;
  String? city;
  String? address;

  AddressItem({String? id, this.country, this.city, this.address})
    : id = id ?? DateTime.now().microsecondsSinceEpoch.toString();

  @override
  String toString() =>
      'AddressItem(id: $id, country: $country, city: $city, address: $address)';
}
