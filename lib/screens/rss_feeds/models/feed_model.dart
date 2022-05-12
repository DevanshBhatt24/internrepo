class FeedModel {
  final String displayImage;
  final String article_url;
  final String link;
  final String published;
  final String title;
  final int timeStamp;
  final String sourcePage;

  FeedModel(
      {this.displayImage,
      this.article_url,
      this.link,
      this.published,
      this.timeStamp,
      this.sourcePage,
      this.title});

  factory FeedModel.fromJson(Map<String, dynamic> json) {
    return FeedModel(
      displayImage: json['display_image'],
      link: json['link'],
      published: json['published'],
      title: json['title'],
      sourcePage: json['source_page'],
      timeStamp: json['timestamp'],
      article_url: json['article_url'] ?? '',
    );
  }
}
