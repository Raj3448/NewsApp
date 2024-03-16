import 'package:headline_hub/db/localdb.dart';
import 'package:headline_hub/model/isardb/saved_new_dto.dart';
import 'package:isar/isar.dart';

class SavedNewsIsarApi {
  late Future<Isar> db;

  static final SavedNewsIsarApi _instance = SavedNewsIsarApi._private();

  SavedNewsIsarApi._private() {
    db = openDB();
    print("Isar Data Base is Initialized");
  }

  factory SavedNewsIsarApi() {
    return _instance;
  }

  Future<void> insert(SavedNewDto newInstance) async {
    final isar = await db;
    isar.writeTxnSync(() => isar.savedNewDtos.putSync(
          newInstance,
        ));
  }

  Future<void> update(SavedNewDto newInstance) async {
    final isar = await db;
    isar.writeTxn(() => isar.savedNewDtos.put(newInstance));
  }

  Future<void> delete(String id) async {
    final isar = await db;
    isar.writeTxn(() => isar.savedNewDtos.delete(int.parse(id)));
  }

  Future<SavedNewDto?> getSavedNewsModelItem(String id) async {
    final isar = await db;
    return await isar.savedNewDtos.get(int.parse(id));
  }

  Future<void> cleanDb() async {
    final isar = await db;
    await isar.writeTxn(() => isar.clear());
  }

  Future<List<SavedNewDto>> getIsarSavedNewsModelList() async {
    final isar = await db;
    return await isar.savedNewDtos.where().findAll();
  }

  Stream<List<SavedNewDto>> listenToSavedNewsModels() async* {
    final isar = await db;
    yield* isar.savedNewDtos.where().watch();
  }
}
