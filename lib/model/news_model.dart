// To parse this JSON data, do
//
//     final newsModel = newsModelFromJson(jsonString);

import 'dart:convert';

NewsModel newsModelFromJson(String str) => NewsModel.fromJson(json.decode(str));

String newsModelToJson(NewsModel data) => json.encode(data.toJson());

class NewsModel {
    String? status;
    int? totalResults;
    List<Result>? results;
    String? nextPage;

    NewsModel({
        this.status,
        this.totalResults,
        this.results,
        this.nextPage,
    });

    factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        status: json["status"],
        totalResults: json["totalResults"],
        results: json["results"] == null ? [] : List<Result>.from(json["results"]!.map((x) => Result.fromJson(x))),
        nextPage: json["nextPage"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
        "nextPage": nextPage,
    };
}

class Result {
    String? articleId;
    String? title;
    String? link;
    dynamic keywords;
    dynamic creator;
    dynamic videoUrl;
    String? description;
    String? content;
    String? pubDate;
    String? imageUrl;
    String? sourceId;
    int? sourcePriority;
    String? sourceUrl;
    String? sourceIcon;
    String? language;
    List<String>? country;
    List<String>? category;
    String? aiTag;
    String? sentiment;
    String? sentimentStats;
    String? aiRegion;

    Result({
        this.articleId,
        this.title,
        this.link,
        this.keywords,
        this.creator,
        this.videoUrl,
        this.description,
        this.content,
        this.pubDate,
        this.imageUrl,
        this.sourceId,
        this.sourcePriority,
        this.sourceUrl,
        this.sourceIcon,
        this.language,
        this.country,
        this.category,
        this.aiTag,
        this.sentiment,
        this.sentimentStats,
        this.aiRegion,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        articleId: json["article_id"],
        title: json["title"],
        link: json["link"],
        keywords: json["keywords"],
        creator: json["creator"],
        videoUrl: json["video_url"],
        description: json["description"],
        content: json["content"],
        pubDate: json["pubDate"],
        imageUrl: json["image_url"],
        sourceId: json["source_id"],
        sourcePriority: json["source_priority"],
        sourceUrl: json["source_url"],
        sourceIcon: json["source_icon"],
        language: json["language"],
        country: json["country"] == null ? [] : List<String>.from(json["country"]!.map((x) => x)),
        category: json["category"] == null ? [] : List<String>.from(json["category"]!.map((x) => x)),
        aiTag: json["ai_tag"],
        sentiment: json["sentiment"],
        sentimentStats: json["sentiment_stats"],
        aiRegion: json["ai_region"],
    );

    Map<String, dynamic> toJson() => {
        "article_id": articleId,
        "title": title,
        "link": link,
        "keywords": keywords,
        "creator": creator,
        "video_url": videoUrl,
        "description": description,
        "content": content,
        "pubDate": pubDate,
        "image_url": imageUrl,
        "source_id": sourceId,
        "source_priority": sourcePriority,
        "source_url": sourceUrl,
        "source_icon": sourceIcon,
        "language": language,
        "country": country == null ? [] : List<dynamic>.from(country!.map((x) => x)),
        "category": category == null ? [] : List<dynamic>.from(category!.map((x) => x)),
        "ai_tag": aiTag,
        "sentiment": sentiment,
        "sentiment_stats": sentimentStats,
        "ai_region": aiRegion,
    };
}
