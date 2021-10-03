class NewsModel {

  late String newsHead ;
  late String newsDes ;
  late String newsImg ;
  late String newsUrl ;

  NewsModel({ this.newsHead = "HEADING", this.newsDes = "NEWS_DESCRIPTION", this.newsImg = "IMAGE", this.newsUrl = "URL"});

  factory NewsModel.fromMap(Map news) {
    return NewsModel(
      newsHead: news["title"],
      newsDes: news["decription"],
      newsImg: news["images"],
      newsUrl: news["read-more"],
    );
  }

}