// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation

import 'package:forestryapp/enums/us_state.dart';

/// Intermediate class to act as a bucket for collecting model data to send off
/// to DB.
///
/// Not responsible for any behavior (i.e. methods) only state.
class DTOLandowner {
  // Public Fields //////////////////////////////////////////////////////////////
  late int id; // For updating/deletion only. Don't use for landowner creation.
  late String name;
  late String email;
  late String address;
  late String city;
  late USState usState;
  late String zip;

  // Constructor ///////////////////////////////////////////////////////////////
  // No parameters. Set attribute values publicly.
  DTOLandowner();

  // Methods //////////////////////////////////////////////////////////////////

  // Helper function for debugging purposes only.
  @override
  String toString() {
    return 'name: $name,' +
        'email: $email,' +
        'address: $address' +
        'city: $city,' +
        'state: $usState,' +
        'zip: $zip';
  }
}
