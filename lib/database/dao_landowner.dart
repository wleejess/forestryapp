import 'package:forestryapp/database/database_manager.dart';
import 'package:forestryapp/models/landowner.dart';

class DAOLandowner {
  // Static Variables //////////////////////////////////////////////////////////
  // Column names in from database when converted to Dart [Map] keys.
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
}
