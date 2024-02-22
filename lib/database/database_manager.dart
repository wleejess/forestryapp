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

  /// Filename of database on device.
  ///
  /// For Android emulator, this can be browsed in the sandboxed file system
  /// using the following `adb`:
  /// # Assuming emulator is running
  /// $ adb devices
  /// # Using the number from previous the step, choose emulator to work on.
  /// $ adb your-device-number
  /// # Start `adb` shell in specified emulator
  /// $ adb shell
  /// # Get permission to access the app.
  /// $ run-as com.example.forestryapp
  /// # (Assuming the app is installed and ran at least once) go do directory
  /// sqlite database is located in
  /// $ cd /data/data/com.example.forestryapp/databases
  static const String _filenameDatabase = 'forestryapp.db';

  // SQLite Files. These must each contain at most 1 statement per file.
  /// List of paths for SQL statements needed to create schema.
  static const _pathSchemas = [
    'assets/database/schema/areas.sql',
    'assets/database/schema/landowners.sql',
  ];

  /// List of paths SQL statements needed to populate database with dummy data.
  static const _pathDummyData = [
    'assets/database/ddl_statements/dummy_landowners.sql',
  ];
  static const String _pathReadAllLandowners =
      'assets/database/queries/read_all_landowners.sql';
  static const String _pathSaveNewLandowner =
      'assets/database/ddl_statements/save_new_landowner.sql';

  static const String _pathReadArea =
      'assets/database/queries/read_all_areas.sql';
  static const String _pathSaveNewArea =
      'assets/database/ddl_statements/save_new_area.sql';

  // SQL strings (read from the above SQLite files).
  /// List of SQL statements needed to create schema.
  static final List<String> _sqlSchemas = [];

  /// List of SQL statements needed to populate database with dummy data.
  static final List<String> _sqlDummyData = [];
  static late final String _sqlReadAllLandowners;
  static late final String _sqlSaveNewLandowner;
  static late final String _sqlReadArea;
  static late final String _sqlSaveNewArea;

  /// The single instance of the database manager.
  ///
  /// This can be accessed anyhwere once the class is imported.
  static late final DatabaseManager _instance;

  // Instance Variables ////////////////////////////////////////////////////////
  // The actual sqflite database.
  late final Database _db;

  // Constructor ///////////////////////////////////////////////////////////////
  /// Private constructor in order to avoid accidental creation of more than one
  /// instance.
  ///
  /// Prevents anyone from instantiating it directly. Allows control of how many
  /// instances are running.
  DatabaseManager._({required Database database}) : _db = database;

  // Initialization ////////////////////////////////////////////////////////////
  /// This must be run before starting the app.
  static Future initialize() async {
    _readSQLFromFile();

    final db = await openDatabase(
      _filenameDatabase,
      version: 1,
      onCreate: _createFromSchema,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
    _instance = DatabaseManager._(database: db);
  }

  /// Read queries/DDL-statements from SQL files declared assets.
  static void _readSQLFromFile() async {
    // One Time Initialization Statements
    _readMultipleSQLFilesIntoList(_pathSchemas, _sqlSchemas);
    _readMultipleSQLFilesIntoList(_pathDummyData, _sqlDummyData);

    // Typical Usage Statements
    _sqlSaveNewLandowner = await rootBundle.loadString(_pathSaveNewLandowner);
    _sqlReadAllLandowners = await rootBundle.loadString(_pathReadAllLandowners);
    _sqlSaveNewArea = await rootBundle.loadString(_pathSaveNewArea);
    _sqlReadArea = await rootBundle.loadString(_pathReadArea);
  }

  static void _readMultipleSQLFilesIntoList(
      List<String> paths, List<String> statementStorageList) async {
    for (var path in paths) {
      statementStorageList.add(await rootBundle.loadString(path));
    }
  }

  /// Create the schema for each table.
  ///
  /// This runs the first time after the app installs
  /// (https://stackoverflow.com/a/63109482) as it is called in the [onCreate]
  /// parameter of sqflite's [openDatabase] function.
  static FutureOr<void> _createFromSchema(Database db, int version) async {
    // IMPORTANT: `db.execute()` only executes the first SQL statement in a
    // string. Hence it is important to declare the SQL assets with only a
    // single SQL statement per file.

    // NOTE: Due to asynchronicity, do not run multiple loops calling
    // `db.execute()` in their body as the execution of the loops may get of
    // sync. This is especially important if later statements depend on the
    // results of earlier statements (e.g. dummy data depending on tables being
    // created).

    /// Execute in the order they appear in the list.
    for (var statement in [..._sqlSchemas, ..._sqlDummyData]) {
      await db.execute(statement);
    }
  }

  // Public API For Use with DAOs //////////////////////////////////////////////

  /// Exposes a reference to the single instance.
  factory DatabaseManager.getInstance() {
    return _instance;
  }

  // Fetch all landowners from the database.
  Future<List<Map<String, dynamic>>> readLandowners() async {
    return await _db.rawQuery(DatabaseManager._sqlReadAllLandowners);
  }

  /// Create a landowner on the database.
  ///
  /// [queryArgs] Should be list of ALL values specified in
  /// [_sqlSaveNewLandowner] in the correct order.
  void saveNewLandowner(List<String> queryArgs) async {
    return _db.transaction((txn) async {
      await txn.rawInsert(_sqlSaveNewLandowner, queryArgs);
    });
  }

  // Fetch all landowners from the database.
  Future<List<Map<String, dynamic>>> readArea() async {
    return await _db.rawQuery(DatabaseManager._sqlReadArea);
  }

  /// Create a landowner on the database.
  ///
  /// [queryArgs] Should be list of ALL values specified in
  /// [_sqlSaveNewLandowner] in the correct order.
  void saveNewArea(List<String> queryArgs) async {
    return _db.transaction((txn) async {
      await txn.rawInsert(_sqlSaveNewArea, queryArgs);
    });
  }
}
