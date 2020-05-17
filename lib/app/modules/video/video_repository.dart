import 'package:dio/dio.dart';
import 'package:youtube_api/shared/constants.dart';
import 'package:youtube_api/shared/models/video_model.dart';

class VideoRepository {
  final Dio client;

  VideoRepository(this.client);

  Future<String> getImage({String idChannel}) async {
    var response = await client.get("/channels",
        queryParameters: {'key': API_KEY, 'part': 'snippet', 'id': idChannel});
    return (response.data['items'] as List).first['snippet']['thumbnails']
        ['high']['url'];
  }
}
