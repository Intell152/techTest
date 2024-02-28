import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'package:minsait_tech_test/src/models/models.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDb();
  }

  Future<Isar> openDb() async {
    final dir = await getApplicationDocumentsDirectory();

    if (Isar.instanceNames.isEmpty) {
      await Isar.open(
        [
          MovieSchema,
          ActorSchema,
          UserSchema,
        ],
        directory: dir.path,
        inspector: true,
      );
    }

    return Future.value(Isar.getInstance());
  }
}