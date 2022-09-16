import 'package:floor/floor.dart';

@entity
class Journal {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String body;
  final String? title;
  final DateTime timestamp;

  Journal({
    this.id,
    required this.title,
    required this.body,
    required this.timestamp,
  });

  factory Journal.fromBody(String body) => Journal(
        id: null,
        title: null,
        body: body,
        timestamp: DateTime.now(),
      );

  factory Journal.empty() => Journal(
        id: null,
        title: null,
        body: "empty",
        timestamp: DateTime.now(),
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Journal &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          body == other.body &&
          title == other.title &&
          timestamp == other.timestamp;

  @override
  int get hashCode =>
      id.hashCode ^ body.hashCode ^ title.hashCode ^ timestamp.hashCode;

  @override
  String toString() =>
      "Journal{id: $id, body: $body, title: $title, timestamp: $timestamp}";

  Journal copyWith({
    int? id,
    String? title,
    String? body,
    DateTime? timestamp,
  }) =>
      Journal(
        id: id ?? this.id,
        title: title ?? this.title,
        body: body ?? this.body,
        timestamp: timestamp ?? this.timestamp,
      );
}
