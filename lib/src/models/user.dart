import 'package:isar/isar.dart';

part 'user.g.dart';

@collection
class User {
  Id id = Isar.autoIncrement;
  final String? fullName;
  final String? email;
  final String? phone;
  final String? registerDate;
  final String? image;
  final String? banner;
  final List<String>? reviews;

  User({
    // required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.registerDate,
    required this.image,
    required this.banner,
    required this.reviews,
  });

  User copyWith({
    int? id,
    String? fullName,
    String? email,
    String? phone,
    String? registerDate,
    String? image,
    String? banner,
    List<String>? reviews,
  }) =>
      User(
        // id: id ?? this.id,
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        registerDate: registerDate ?? this.registerDate,
        image: image ?? this.image,
        banner: banner ?? this.banner,
        reviews: reviews ?? this.reviews,
      );

  factory User.fromObject(Object? object) {
    if (object is User) {
      return User(
        // id: object.id,
        fullName: object.fullName,
        email: object.email,
        phone: object.phone,
        registerDate: object.registerDate,
        image: object.image,
        banner: object.banner,
        reviews: object.reviews,
      );
    }
    throw ArgumentError('Invalid object type');
  }

  factory User.fromJson(Map<String, dynamic> json, int type) => User(
        // id: json['id'],
        fullName: json['fullName'],
        email: json['email'],
        phone: json['phone'],
        registerDate: json['registerDate'],
        image: json['image'],
        banner: json['banner'],
        reviews: json['reviews'],
      );
}
