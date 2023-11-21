// To parse this JSON data, do
//
//     final categoriesClass = categoriesClassFromJson(jsonString);

import 'dart:convert';

CategoriesClass categoriesClassFromJson(String str) => CategoriesClass.fromJson(json.decode(str));

String categoriesClassToJson(CategoriesClass data) => json.encode(data.toJson());

class CategoriesClass {
    String status;
    int totalResults;
    List<Article> articles;

    CategoriesClass({
        required this.status,
        required this.totalResults,
        required this.articles,
    });

    factory CategoriesClass.fromJson(Map<String, dynamic> json) => CategoriesClass(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: List<Article>.from(json["articles"].map((x) => Article.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
    };
}

class Article {
    Source source;
    String author;
    String title;
    String description;
    String url;
    String? urlToImage;
    DateTime publishedAt;
    String content;

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

    factory Article.fromJson(Map<String, dynamic> json) => Article(
        source: Source.fromJson(json["source"]),
        author: json["author"] ?? "",
        title: json["title"],
        description: json["description"] ?? "",
        url: json["url"] ?? "",
        urlToImage: json["urlToImage"]?? '',
        publishedAt: DateTime.parse(json["publishedAt"]),
        content: json["content"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "source": source.toJson(),
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt.toIso8601String(),
        "content": content,
    };
}

class Source {
    dynamic id;
    String name;

    Source({
        required this.id,
        required this.name,
    });

    factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
