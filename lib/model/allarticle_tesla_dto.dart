import 'package:json_annotation/json_annotation.dart';
part 'allarticle_tesla_dto.g.dart';

@JsonSerializable()
class AllArticlesAboutTesla {
  @JsonKey(name: "status")
  final String status;
  @JsonKey(name: "totalResults")
  final int totalResults;
  @JsonKey(name: "articles")
  final List<Article> articles;

  AllArticlesAboutTesla({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory AllArticlesAboutTesla.fromJson(Map<String, dynamic> json) =>
      _$AllArticlesAboutTeslaFromJson(json);

  Map<String, dynamic> toJson() => _$AllArticlesAboutTeslaToJson(this);
}

@JsonSerializable()
class Article {
  @JsonKey(name: "source")
  final Source source;
  @JsonKey(name: "author")
  final String author;
  @JsonKey(name: "title")
  final String title;
  @JsonKey(name: "description")
  final String description;
  @JsonKey(name: "url")
  final String url;
  @JsonKey(name: "urlToImage")
  final String urlToImage;
  @JsonKey(name: "publishedAt")
  final DateTime publishedAt;
  @JsonKey(name: "content")
  final String content;

  Article({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}

@JsonSerializable()
class Source {
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "name")
  final String name;

  Source({
    required this.id,
    required this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);

  Map<String, dynamic> toJson() => _$SourceToJson(this);
}
