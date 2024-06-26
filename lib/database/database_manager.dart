import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

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
    'assets/database/ddl_statements/dummy_areas.sql',
  ];
  static const String _pathReadAllLandowners =
      'assets/database/queries/read_all_landowners.sql';
  static const String _pathSaveNewLandowner =
      'assets/database/ddl_statements/save_new_landowner.sql';
  static const String _pathUpdateExistingLandowner =
      'assets/database/ddl_statements/update_existing_landowner.sql';
  static const String _pathDeleteLandowner =
      'assets/database/ddl_statements/delete_landowner.sql';

  static const String _pathReadArea = 'assets/database/queries/read_area.sql';
  static const String _pathSaveNewArea =
      'assets/database/ddl_statements/save_new_area.sql';
  static const String _pathUpdateExistingArea =
      'assets/database/ddl_statements/update_existing_area.sql';
  static const String _pathDeleteArea =
      'assets/database/ddl_statements/delete_area.sql';

  // Relationship queries
  static const String _pathReadAreasFromLandowner =
      'assets/database/queries/read_areas_from_landowner.sql';

  // SQL strings (read from the above SQLite files).
  /// List of SQL statements needed to create schema.
  static final List<String> _sqlSchemas = [];

  /// List of SQL statements needed to populate database with dummy data.
  static final List<String> _sqlDummyData = [];
  static late final String _sqlReadAllLandowners;
  static late final String _sqlSaveNewLandowner;
  static late final String _sqlUpdateExitsingLandowner;
  static late final String _sqlDeleteLandowner;
  static late final String _sqlReadArea;
  static late final String _sqlSaveNewArea;
  static late final String _sqlUpdateExitsingArea;
  static late final String _sqlDeleteArea;

  // Relationship queries
  static late String _sqlReadAreasFromLandowner;

  /// The single instance of the database manager.
  ///
  /// This can be accessed anyhwere once the class is imported.
  static late final DatabaseManager _instance;

  // Instance Variables ////////////////////////////////////////////////////////
  // The actual sqflite database.
  final Database _db;

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
    await _readSQLFromFile();

    if (kIsWeb) {
      // If this is not called then all sqflite methods will fail when on web
      // since sqflite was not designed for web use.
      // https://pub.dev/packages/sqflite_common_ffi_web#add-web-support-to-existing-sqflite-application
      databaseFactory = databaseFactoryFfiWeb;

      // NOTE ON WEB DEPLOYMENT INSTRUCTIONS:
      // The web version has no easy way of deleting the database. We can't just
      // uninstall the app and reintstall like on mobile. This means that if we
      // make changes to the web demo version's database there will be no apply
      // them to the sponsor's device because database creation only happens if
      // the database does not exist. We can force non-existence by deleting
      // database each time on web version. This will not affect usage because
      // the web usage is not being used in the field. Uncommenting the
      // following line will make it so the database on the web vesrion is reset
      // each time and should only be used if the web version is being used for
      // demonstration purposes and not actual use in the field.
      // await databaseFactory.deleteDatabase(_filenameDatabase);
    }

    final db = await openDatabase(
      _filenameDatabase,
      version: 1,
      onCreate: _createFromSchema,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
    _instance = DatabaseManager._(database: db);
  }

  /// Read queries/DDL-statements from SQL files declared assets.
  static Future<void> _readSQLFromFile() async {
    // One Time Initialization Statements
    await _readMultipleSQLFilesIntoList(_pathSchemas, _sqlSchemas);
    await _readMultipleSQLFilesIntoList(_pathDummyData, _sqlDummyData);

    // Typical Usage Statements
    _sqlSaveNewLandowner = await rootBundle.loadString(_pathSaveNewLandowner);
    _sqlReadAllLandowners = await rootBundle.loadString(_pathReadAllLandowners);
    _sqlSaveNewArea = await rootBundle.loadString(_pathSaveNewArea);
    _sqlReadArea = await rootBundle.loadString(_pathReadArea);
    _sqlUpdateExitsingLandowner = await rootBundle.loadString(
      _pathUpdateExistingLandowner,
    );
    _sqlUpdateExitsingArea = await rootBundle.loadString(
      _pathUpdateExistingArea,
    );
    _sqlDeleteLandowner = await rootBundle.loadString(_pathDeleteLandowner);
    _sqlDeleteArea = await rootBundle.loadString(_pathDeleteArea);

    // Relationship queries
    _sqlReadAreasFromLandowner =
        await rootBundle.loadString(_pathReadAreasFromLandowner);
  }

  static Future<void> _readMultipleSQLFilesIntoList(
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
  Future<int> saveNewLandowner(List<String> queryArgs) async {
    return _db.transaction((transaction) async {
      return await transaction.rawInsert(_sqlSaveNewLandowner, queryArgs);
    });
  }

  /// Edit an existing landowner on the database.
  ///
  /// [queryArgs] Should be list of ALL values specified in
  /// [_sqlUpdateExitsingLandowner] in the correct order.
  Future<int> updateExistingLandowner(List<dynamic> queryArgs) async {
    return _db.transaction(
      (transaction) async {
        return await transaction.rawUpdate(
          _sqlUpdateExitsingLandowner,
          queryArgs,
        );
      },
    );
  }

  /// Delete an existing landowner on the database.
  ///
  /// [queryArgs] Should be list of ALL values specified in
  /// [_sqlDeleteLandowner] in the correct order.
  Future<int> deleteLandowner(List<dynamic> queryArgs) async {
    return _db.transaction(
      (transaction) async {
        return await transaction.rawDelete(_sqlDeleteLandowner, queryArgs);
      },
    );
  }

  // Fetch areas from the database.
  Future<List<Map<String, dynamic>>> readArea() async {
    return await _db.rawQuery(DatabaseManager._sqlReadArea);
  }

  /// Create an area on the database.
  ///
  /// [queryArgs] Should be list of ALL values specified in
  /// [_sqlSaveNewLandowner] in the correct order.
  Future<int> saveNewArea(List<dynamic> queryArgs) async {
    return await _db.transaction((transaction) async {
      return await transaction.rawInsert(_sqlSaveNewArea, queryArgs);
    });
  }

  /// Edit an existing area on the database.
  ///
  /// [queryArgs] Should be list of ALL values specified in
  /// [_sqlUpdateExitsingArea] in the correct order.
  Future<int> updateExistingArea(List<dynamic> queryArgs) async {
    return await _db.transaction(
      (transaction) async {
        return await transaction.rawUpdate(_sqlUpdateExitsingArea, queryArgs);
      },
    );
  }

  /// Delete an existing area on the database.
  ///
  /// [queryArgs] Should be list of ALL values specified in
  /// [_sqlDeleteArea] in the correct order.
  Future<int> deleteArea(List<dynamic> queryArgs) async {
    return _db.transaction(
      (transaction) async {
        return await transaction.rawDelete(_sqlDeleteArea, queryArgs);
      },
    );
  }

  // Relationship Queries //////////////////////////////////////////////////////
  /// Given a landowner, find all areas that they own.
  Future<List<Map<String, dynamic>>> readAreasFromLandowner(
    List<int> queryArgs,
  ) async {
    return await _db.rawQuery(
        DatabaseManager._sqlReadAreasFromLandowner, queryArgs);
  }
}
