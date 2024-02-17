// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation

import 'package:forestryapp/enums/us_state.dart';

/// Intermediate class to act as a bucket for collecting model data to send off
/// to DB.
///
/// Not responsible for any state functionality, only data transfer.
class DTOLandowner {
  // Public Fields //////////////////////////////////////////////////////////////
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

  // Helper function for debugging purposes.
  @override
  String toString() {
    return 'name: $name,' +
        'email: $email,' +
        'address: $address' +
        'city: $city,' +
        'state: $usState,' +
        'zip: $zip';
  }

  List formQueryArguments() {
    return [name, email, address, city, usState.label, zip];
  }
}
