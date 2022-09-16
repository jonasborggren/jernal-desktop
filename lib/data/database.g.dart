// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  JournalDao? _journalDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Journal` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `body` TEXT NOT NULL, `title` TEXT, `timestamp` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  JournalDao get journalDao {
    return _journalDaoInstance ??= _$JournalDao(database, changeListener);
  }
}

class _$JournalDao extends JournalDao {
  _$JournalDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _journalInsertionAdapter = InsertionAdapter(
            database,
            'Journal',
            (Journal item) => <String, Object?>{
                  'id': item.id,
                  'body': item.body,
                  'title': item.title,
                  'timestamp': _dateTimeConverter.encode(item.timestamp)
                },
            changeListener),
        _journalUpdateAdapter = UpdateAdapter(
            database,
            'Journal',
            ['id'],
            (Journal item) => <String, Object?>{
                  'id': item.id,
                  'body': item.body,
                  'title': item.title,
                  'timestamp': _dateTimeConverter.encode(item.timestamp)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Journal> _journalInsertionAdapter;

  final UpdateAdapter<Journal> _journalUpdateAdapter;

  @override
  Future<List<Journal>> all() async {
    return _queryAdapter.queryList('SELECT * FROM Journal',
        mapper: (Map<String, Object?> row) => Journal(
            id: row['id'] as int?,
            title: row['title'] as String?,
            body: row['body'] as String,
            timestamp: _dateTimeConverter.decode(row['timestamp'] as int)));
  }

  @override
  Stream<Journal?> byId(int id) {
    return _queryAdapter.queryStream('SELECT * FROM Journal WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Journal(
            id: row['id'] as int?,
            title: row['title'] as String?,
            body: row['body'] as String,
            timestamp: _dateTimeConverter.decode(row['timestamp'] as int)),
        arguments: [id],
        queryableName: 'Journal',
        isView: false);
  }

  @override
  Future<void> insertJournal(Journal data) async {
    await _journalInsertionAdapter.insert(data, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateJournal(Journal data) async {
    await _journalUpdateAdapter.update(data, OnConflictStrategy.abort);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
