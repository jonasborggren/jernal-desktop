import 'package:floor/floor.dart';
import 'package:jernal/data/models/journal.dart';

@dao
abstract class JournalDao {
  @Query('SELECT * FROM Journal')
  Future<List<Journal>> all();

  @Query('SELECT * FROM Journal WHERE id = :id')
  Stream<Journal?> byId(int id);

  @insert
  Future<void> insertJournal(Journal data);

  @update
  Future<void> updateJournal(Journal data);

  @delete
  Future<void> deleteJournal(Journal data);
}
