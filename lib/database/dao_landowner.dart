import 'package:forestryapp/database/database_manager.dart';
import 'package:forestryapp/database/dto_landowner.dart';
import 'package:forestryapp/models/landowner.dart';

/// Class to facilitate communication between layout code and [DatabaseManager].
///
/// This class should contain no instance data.
class DAOLandowner {
  // Static Variables //////////////////////////////////////////////////////////
  // Column names for incoming data from database for use in Dart [Map] keys.
  static const colID = 'id';
  static const colName = 'name';
  static const colEmail = 'email';
  static const colAddress = 'address';
  static const colCity = 'city';
  static const colUSState = 'us_state';
  static const colZip = 'zip';

  // Reading from database /////////////////////////////////////////////////////
  static Future<List<Landowner>> fetchFromDatabase() async {
    final dbRecords = await DatabaseManager.getInstance().readLandowners();
    return dbRecords.map((Map record) => Landowner.fromMap(record)).toList();
  }

  // Writing to Database ///////////////////////////////////////////////////////
  /// Insert a new landowner record to the database.
  ///
  /// Assumes all fields except of [dto] are set with the exception of
  /// [dto.id]. The latter can take any value as it has no bearing on the
  /// behavior of this method.
  static Future<int> saveNewLandowner(DTOLandowner dto) async =>
      await DatabaseManager.getInstance()
          .saveNewLandowner(_getNonIDFields(dto));

  /// Edit an existing landowner record alreay on the database.
  ///
  /// Assumes [dto.id] is a valid ID for an existing landowner.
  static void updateExistingLandowner(DTOLandowner dto) =>
      DatabaseManager.getInstance().updateExistingLandowner(
        [..._getNonIDFields(dto), dto.id],
      );

  /// Remove an existing landowner record from the database.
  ///
  /// Assumes [id] is a valid ID of an existing landowner record.
  static Future<int> deleteLandowner(int id) async =>
      await DatabaseManager.getInstance().deleteLandowner([id]);

  // Helpers ///////////////////////////////////////////////////////////////////
  static List<String> _getNonIDFields(DTOLandowner dto) =>
      [dto.name, dto.email, dto.address, dto.city, dto.usState.label, dto.zip];
}
