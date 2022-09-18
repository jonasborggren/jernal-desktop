// required package imports
import 'dart:async';

import 'package:floor/floor.dart';
import 'package:jernal/data/dao/converters/datetime.dart';
import 'package:jernal/data/dao/dao_journal.dart';
import 'package:jernal/data/models/journal.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

/// Run the generator with
/// flutter packages pub run build_runner build
///
/// To automatically run it, whenever a file changes, use
/// flutter packages pub run build_runner watch
part '../database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Journal])
@TypeConverters([DateTimeConverter])
abstract class AppDatabase extends FloorDatabase {
  JournalDao get journalDao;
}
