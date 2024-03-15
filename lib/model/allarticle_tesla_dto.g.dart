// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allarticle_tesla_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllArticlesAboutTesla _$AllArticlesAboutTeslaFromJson(
        Map<String, dynamic> json) =>
    AllArticlesAboutTesla(
      status: json['status'] as String ?? '',
      totalResults: json['totalResults'] == null ? null:json['totalResults'] as int ?? 0,
      articles: (json['articles'] as List<dynamic>)
          .map((e) => Article.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllArticlesAboutTeslaToJson(
        AllArticlesAboutTesla instance) =>
    <String, dynamic>{
      'status': instance.status,
      'totalResults': instance.totalResults ?? 0,
      'articles': instance.articles ?? [],
    };

Article _$ArticleFromJson(Map<String, dynamic> json) => Article(
      source: Source.fromJson(json['source'] as Map<String, dynamic>),
      author: json['author']== null ? null : json['author'] as String ?? '',
      title: json['title']== null ? null :json['title'] as String ?? '',
      description: json['description']== null ? null :json['description'] as String ?? '',
      url: json['url']== null ? null :json['url'] as String ?? '',
      urlToImage: json['urlToImage'] == null ? null : json['urlToImage'] as String ?? '',
      publishedAt: DateTime.parse(json['publishedAt'] as String ?? ''),
      content: json['content']== null ? null :json['content'] as String ?? '',
    );

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'source': instance.source ,
      'author': instance.author ?? '',
      'title': instance.title ?? '',
      'description': instance.description ?? '',
      'url': instance.url ?? '' ,
      'urlToImage': instance.urlToImage ?? '',
      'publishedAt': instance.publishedAt.toIso8601String()?? '',
      'content': instance.content ?? '',
    };

Source _$SourceFromJson(Map<String, dynamic> json) => Source(
    id: json['id'] == null ? DateTime.now().millisecondsSinceEpoch.toString() : json['id'] as String,
    name: json['name'] == null ? null : json['name'] as String,
  );

Map<String, dynamic> _$SourceToJson(Source instance) => <String, dynamic>{
      'id': instance.id ?? '',
      'name': instance.name ?? '',
    };
