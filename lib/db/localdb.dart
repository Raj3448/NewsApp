import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../model/isardb/saved_new_dto.dart';
Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open([SavedNewDtoSchema],
          inspector: true, directory: dir.path);
    }
    return Future.value(Isar.getInstance());
  }