class VideoModel {
  String id;
  String idChannel;
  String title;
  String url;
  String thumbnailUrl;
  String channelTitle;
  String publishedAt;

  VideoModel({this.id, this.title, this.url, this.thumbnailUrl});

  VideoModel.fromJson(Map<String, dynamic> json) {
    id = json['id']['videoId'];
    idChannel = json['snippet']['channelId'];
    publishedAt = json['snippet']['publishedAt'];
    channelTitle = json['snippet']['channelTitle'];
    title = json['snippet']['title'];
    url = json['snippet']['thumbnails']['high']['url'];
    thumbnailUrl = json['thumbnailUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['url'] = this.url;
    data['thumbnailUrl'] = this.thumbnailUrl;
    return data;
  }
}
