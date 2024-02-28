import 'package:isar/isar.dart';

part 'actor.g.dart';

@collection
class Actor {
  Id id = Isar.autoIncrement;
  int? eventId;
  String? image;
  String? name;

  Actor({
    required this.id,
    required this.eventId,
    required this.image,
    required this.name,
  });

  Actor copyWith({
    int? id,
    int? eventId,
    String? image,
    String? name,
  }) =>
      Actor(
        id: id ?? this.id,
        eventId: eventId ?? this.eventId,
        image: image ?? this.image,
        name: name ?? this.name,
      );

  factory Actor.fromObject(Object? object) {
    if (object is Actor) {
      return Actor(
        id: object.id,
        eventId: object.eventId,
        image: object.image,
        name: object.name,
      );
    }
    throw ArgumentError('Invalid object type');
  }

  factory Actor.fromJson(Map<String, dynamic> json, int id) => Actor(
        id: json['id'],
        eventId: id,
        image: 'https://image.tmdb.org/t/p/w500${json['profile_path']}',
        name: json['name'],
      );
}
