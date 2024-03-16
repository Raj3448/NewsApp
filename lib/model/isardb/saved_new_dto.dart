import 'package:isar/isar.dart';
part 'saved_new_dto.g.dart';

@Collection()
class SavedNewDto {
  Id id = Isar.autoIncrement;
  MyArticle myArticle;

  SavedNewDto({
    
    required this.myArticle,
  });
}



@embedded
class MyArticle {
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  DateTime? publishedAt;
  String? content;
}
