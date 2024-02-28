import 'package:isar/isar.dart';

part 'movie.g.dart';

@collection
class Movie {
  Id id = Isar.autoIncrement;
  final String? name;
  final String? overview;
  final String? poster;
  final String? backdrop;
  final String? originalName;
  final double? rate;
  final int? type;

  Movie({
    required this.id,
    required this.name,
    required this.overview,
    required this.poster,
    required this.backdrop,
    required this.originalName,
    required this.rate,
    required this.type,
  });

  Movie copyWith({
    int? id,
    String? name,
    String? overview,
    String? poster,
    String? backdrop,
    String? originalName,
    double? rate,
    int? type,
  }) =>
      Movie(
        id: id ?? this.id,
        name: name ?? this.name,
        overview: overview ?? this.overview,
        poster: poster ?? this.poster,
        backdrop: backdrop ?? this.backdrop,
        originalName: originalName ?? this.originalName,
        rate: rate ?? this.rate,
        type: type ?? this.type,
      );

  factory Movie.fromObject(Object? object) {
    if (object is Movie) {
      return Movie(
        id: object.id,
        name: object.name,
        overview: object.overview,
        poster: object.poster,
        backdrop: object.backdrop,
        originalName: object.originalName,
        rate: object.rate,
        type: object.type,
      );
    }
    throw ArgumentError('Invalid object type');
  }

  factory Movie.fromJson(Map<String, dynamic> json, int type) => Movie(
        id: json['id'],
        name: json['title'],
        overview: json['overview'],
        poster: 'https://image.tmdb.org/t/p/w500${json['poster_path']}',
        backdrop: 'https://image.tmdb.org/t/p/w500${json['backdrop_path']}',
        originalName: json['original_title'],
        rate: json['vote_average'],
        type: type
      );
}
