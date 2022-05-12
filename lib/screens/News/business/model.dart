class Article {
  String link;
  String published;
  int timestamp;
  String title;

  Article({this.link, this.published, this.timestamp, this.title});

  Article.fromJson(Map<String, dynamic> json) {
    link = json['link'];
    published = json['published'];
    timestamp = json['timestamp'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['link'] = this.link;
    data['published'] = this.published;
    data['timestamp'] = this.timestamp;
    data['title'] = this.title;
    return data;
  }
}

class FullArticle {
  List<dynamic> fullText;
  String link;
  String summary;
  String title;
  FullArticle({this.fullText, this.link, this.summary, this.title});

  FullArticle.fromJson(Map<String, dynamic> json) {
    fullText = json['full_text'];
    link = json['link'];
    summary = json['summary'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full_text'] = this.fullText;
    data['link'] = this.link;
    data['summary'] = this.summary;
    data['title'] = this.title;

    return data;
  }
}

// class News {
//   News({
//      this.title,
//      this.slug,
//      this.url,
//      this.bannerLink,
//      this.imageCourtesy,
//      this.shareAssetLink,
//      this.content,
//      this.sourceLink,
//      this.subscribed,
//      this.bookmarked,
//      this.commentsCount,
//      this.companies,
//      this.pollCount,
//      this.createdAt,
//      this.moreInfo,
//   });
//    String title;
//    String slug;
//    String url;
//    String bannerLink;
//    String imageCourtesy;
//    String shareAssetLink;
//    String content;
//    String sourceLink;
//    String subscribed;
//    String bookmarked;
//    int commentsCount;
//    List<dynamic> companies;
//    int pollCount;
//    String createdAt;
//    MoreInfo moreInfo;
//
//   News.fromJson(Map<String, dynamic> json){
//     title = json['title'];
//     slug = json['slug'];
//     url = json['url'];
//     bannerLink = json['banner_link'];
//     imageCourtesy = json['image_courtesy'];
//     shareAssetLink = json['share_asset_link'];
//     content = json['content'];
//     sourceLink = json['source_link'];
//     subscribed = null;
//     bookmarked = null;
//     commentsCount = json['comments_count'];
//     companies = List.castFrom<dynamic, dynamic>(json['companies']);
//     pollCount = json['poll_count'];
//     createdAt = json['created_at'];
//     moreInfo = MoreInfo.fromJson(json['more_info']);
//   }
//
//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['title'] = title;
//     _data['slug'] = slug;
//     _data['url'] = url;
//     _data['banner_link'] = bannerLink;
//     _data['image_courtesy'] = imageCourtesy;
//     _data['share_asset_link'] = shareAssetLink;
//     _data['content'] = content;
//     _data['source_link'] = sourceLink;
//     _data['subscribed'] = subscribed;
//     _data['bookmarked'] = bookmarked;
//     _data['comments_count'] = commentsCount;
//     _data['companies'] = companies;
//     _data['poll_count'] = pollCount;
//     _data['created_at'] = createdAt;
//     _data['more_info'] = moreInfo.toJson();
//     return _data;
//   }
// }

class News {
  News(
      {this.title,
      this.url,
      this.bannerLink,
      this.content,
      this.createdAt,
      this.sourceLink,
      this.createdAt_unix});
  String title;
  String url;
  String bannerLink;
  String content;
  String createdAt;
  String createdAt_unix;
  String sourceLink;
  // String companies_name;
  // String companies_industry;

  News.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    url = json['url'];
    bannerLink = json['banner_link'];
    content = json['content'];
    sourceLink = json['sourcelink'];
    createdAt = json['createdAt'];
    createdAt_unix = json['createdAt_unix'];
    // companies_name = json['companies']['companies_name'];
    // companies_industry = json['companies']['companies_industry'];
  }

  //TODO: companies section is not added here.
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['title'] = title;
    _data['url'] = url;
    _data['banner_link'] = bannerLink;
    _data['content'] = content;
    _data['created_at'] = createdAt;
    _data['sourcelink'] = sourceLink;
    _data['createdAt_unix'] = createdAt_unix;
    return _data;
  }
}

class MoreInfo {
  MoreInfo({
    this.text,
    this.type,
    this.color,
    this.link,
  });
  String text;
  String type;
  String color;
  String link;

  MoreInfo.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      text = json['text'];
      type = json['type'];
      color = json['color'];
      link = json['link'];
    } else {
      text = "No Data";
      type = "No Data";
      color = "No Data";
      link = "No Data";
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['text'] = text;
    _data['type'] = type;
    _data['color'] = color;
    _data['link'] = link;
    return _data;
  }
}

class NewsPulseModel {
  dynamic date;
  String description;
  List newsItemSecurities;
  List newsItemsSectors;
  List newsItemIndustries;

  NewsPulseModel(
      {this.date,
      this.description,
      this.newsItemIndustries,
      this.newsItemSecurities,
      this.newsItemsSectors});

  factory NewsPulseModel.fromJson(Map<String, dynamic> jsonData) {
    final months = {
      1: 'Jan',
      2: 'Feb',
      3: 'Mar',
      4: 'Apr',
      5: 'May',
      6: 'Jun',
      7: 'Jul',
      8: 'Aug',
      9: 'Sep',
      10: 'Oct',
      11: 'Nov',
      12: 'Dec'
    };
    DateTime d = DateTime.parse(jsonData['Date']);
    return NewsPulseModel(
      date: '${d.day}, ${months[d.month]} ${d.year}' ?? 'N/A',
      description: jsonData['Description'] ?? 'N/A',
      newsItemSecurities: jsonData['NewsitemSecurities'] ?? ['N/A'],
      newsItemsSectors: jsonData['NewsitemSectors'] ?? ['N/A'],
      newsItemIndustries: jsonData['NewsitemIndustries'] ?? ['N/A'],
    );
  }
}
