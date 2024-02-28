import 'package:isar/isar.dart';

import 'package:minsait_tech_test/src/models/models.dart';
import 'package:minsait_tech_test/src/services/services.dart';

class UserService {
  late Future<Isar> db;

  UserService() {
    db = IsarService().db;
  }

  Future<List<User>> getUser() async {
    final isar = await db;

    return await isar.users.where().findAll();
  }

  Future<bool> saveUser(User newUser) async {
    try {
      final isar = await db;

      newUser.id = 1;
      await isar.writeTxn(() async => await isar.users.put(newUser));

      return true;
    } on IsarError catch (error) {
      throw Exception(error.message);
    }
  }
}
