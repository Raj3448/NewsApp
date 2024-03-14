// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allarticle_tesla_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllArticlesAboutTesla _$AllArticlesAboutTeslaFromJson(
        Map<String, dynamic> json) =>
    AllArticlesAboutTesla(
      status: json['status'] as String,
      totalResults: json['totalResults'] as int,
      articles: (json['articles'] as List<dynamic>)
          .map((e) => Article.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllArticlesAboutTeslaToJson(
        AllArticlesAboutTesla instance) =>
    <String, dynamic>{
      'status': instance.status,
      'totalResults': instance.totalResults,
      'articles': instance.articles,
    };

Article _$ArticleFromJson(Map<String, dynamic> json) => Article(
      source: Source.fromJson(json['source'] as Map<String, dynamic>),
      author: json['author'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      url: json['url'] as String,
      urlToImage: json['urlToImage'] as String,
      publishedAt: DateTime.parse(json['publishedAt'] as String),
      content: json['content'] as String,
    );

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'source': instance.source,
      'author': instance.author,
      'title': instance.title,
      'description': instance.description,
      'url': instance.url,
      'urlToImage': instance.urlToImage,
      'publishedAt': instance.publishedAt.toIso8601String(),
      'content': instance.content,
    };

Source _$SourceFromJson(Map<String, dynamic> json) => Source(
      id: json['id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$SourceToJson(Source instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
