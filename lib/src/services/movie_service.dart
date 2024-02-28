import 'package:isar/isar.dart';

import 'package:minsait_tech_test/src/models/models.dart';
import 'package:minsait_tech_test/src/services/services.dart';

class MoviesService {
  late Future<Isar> db;

  MoviesService() {
    db = IsarService().db;
  }

  Future<List<Movie>> getAllMovies() async {
    final isar = await db;

    return await isar.movies.where().findAll();
  }

  Future<bool> saveMovie(Movie newMovie) async {
    try {
      final isar = await db;

      await isar.writeTxn(() async => await isar.movies.put(newMovie));
      return true;
    } on IsarError catch (error) {
      throw Exception(error.message);
    }
  }
}
