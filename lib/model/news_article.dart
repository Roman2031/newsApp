class NewsArticle {
  final String title;
  final String? urlToImage;
  final String publishedAt;
  final String url;
  NewsArticle({
    required this.title,
    required this.urlToImage,
    required this.publishedAt,
    required this.url,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] ?? '',
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'] ?? '',
      url: json['url'] ?? '',
    );
  }
}
