import 'package:isar/isar.dart';

import 'package:minsait_tech_test/src/models/models.dart';
import 'package:minsait_tech_test/src/services/services.dart';

class ActorService {
  late Future<Isar> db;

  ActorService() {
    db = IsarService().db;
  }

  Future<List<Actor>> getAllActors() async {
    final isar = await db;

    return await isar.actors.where().findAll();
  }

  Future<bool> saveActor(Actor newActor) async {
    try {
      final isar = await db;

      await isar.writeTxn(() async => await isar.actors.put(newActor));
      return true;
    } on IsarError catch (error) {
      throw Exception(error.message);
    }
  }
}
