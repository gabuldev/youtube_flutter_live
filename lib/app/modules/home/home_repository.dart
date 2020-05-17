import 'package:dio/dio.dart';
import 'package:youtube_api/shared/constants.dart';
import 'package:youtube_api/shared/models/video_model.dart';

class HomeRepository {
  final Dio client;

  HomeRepository(this.client);

  Future<List<VideoModel>> getVideos({String search}) async {
    var response = await client.get('/search', queryParameters: {
      'key': API_KEY,
      'part': 'snippet,id',
      'order': 'date',
      'maxResults': 15,
      'q': search ?? 'flutterando'
    });
    return (response.data['items'] as List)
        .map((i) => VideoModel.fromJson(i))
        .toList();
  }

  Future<String> getImage({String idChannel}) async {
    var response = await client.get("/channels",
        queryParameters: {'key': API_KEY, 'part': 'snippet', 'id': idChannel});
    return (response.data['items'] as List).first['snippet']['thumbnails']
        ['high']['url'];
  }

  Future<String> getStatistics({String idVideo}) async {
    var response = await client.get("/videos",
        queryParameters: {'key': API_KEY, 'part': 'statistics', 'id': idVideo});
    return (response.data['items'] as List).first['statistics']['viewCount'];
  }
}
