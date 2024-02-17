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
  static const _pathSchemas = [
    'assets/database/schema/areas.sql',
    'assets/database/schema/landowners.sql',
  ];

  static const String _pathDummyData = 'assets/database/dummy_data.sql';
  static const String _pathReadAllLandowners =
      'assets/database/read_all_landowners.sql';

  // Queries
  static final List<String> _sqlSchemas = [];
  static late final String _sqlDummyData;
  static late final String _sqlReadAllLandowners;

  /// The single instance of the database manager.
  ///
  /// This can be accessed anyhwere once the class is imported.
  static late final DatabaseManager _instance;

  // Instance Variables ////////////////////////////////////////////////////////
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
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
    _instance = DatabaseManager._(database: db);
  }

  static void _readQueriesFromFile() async {
    for (var path in _pathSchemas) {
      _sqlSchemas.add(await rootBundle.loadString(path));
    }
    _sqlDummyData = await rootBundle.loadString(_pathDummyData);
    _sqlReadAllLandowners = await rootBundle.loadString(_pathReadAllLandowners);
  }

  static FutureOr<void> _createFromSchema(Database db, int version) async {
    for (var schemaStatement in _sqlSchemas) {
      await db.execute(schemaStatement);
    }
    await db.execute(_sqlDummyData);
  }

  Future<List<Map<String, dynamic>>> readLandowners() async {
    return await _db.rawQuery(DatabaseManager._sqlReadAllLandowners);
  }
}