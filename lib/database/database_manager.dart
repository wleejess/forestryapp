import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart';


/// Singleton used for interacting with SQLite database via [sqflite] and
/// centralizing database code.
///
/// It *MUST* to be initialized before the app starts running to create its
/// single instance. All instances can be accessed via its [.getInstance()]
/// method (similar to how `SharedPreferences` operates). However, unlike
/// [SharedPreferences] its [.getInstance()] is not [async] so there is no need
/// to create a [Provider] for it. Just import it and get the reference.
class DatabaseManager {
  // Static Variables //////////////////////////////////////////////////////////
  // File paths
  static const String _filenameDatabase = 'forestryapp.db';
  static const String _pathCreateSchema = 'assets/database/schema.sql';

  // Queries
  static late final String _sqlCreateSchema;

  /// The single instance of the database manager.
  ///
  /// This can be accessed anyhwere once the class is imported.
  static late final DatabaseManager _instance;

  // Instance Variables ////////////////////////////////////////////////////////
  // ignore: unused_field
  late final Database _db;

  // Constructor ///////////////////////////////////////////////////////////////
  /// Private constructor in order to avoid accidental creation of more than one
  /// instance.
  ///
  /// Prevents anyone from instantiating it directly. Allows control of how many
  /// instances are running.
  DatabaseManager._({required Database database}) : _db = database;

  // Methods ///////////////////////////////////////////////////////////////////
  /// Exposes a reference to the single instance.
  factory DatabaseManager.getInstance() {
    return _instance;
  }

  /// This must be run before starting the app.
  static Future initialize() async {
    _readQueriesFromFile();

    final db = await openDatabase(
      _filenameDatabase,
      version: 1,
      onCreate: _createFromSchema,
    );
    _instance = DatabaseManager._(database: db);
  }

  static void _readQueriesFromFile() async {
    _sqlCreateSchema = await rootBundle.loadString(_pathCreateSchema);
  }

  static FutureOr<void> _createFromSchema(Database db, int version) async {
    await db.execute(_sqlCreateSchema);
  }
}
