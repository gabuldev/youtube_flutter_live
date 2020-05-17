import 'package:rxdart/rxdart.dart';
import 'package:youtube_api/shared/models/video_model.dart';

import 'home_repository.dart';

class HomeBloc {
  final HomeRepository repo;
  HomeBloc(this.repo) {
    videosIn = videos.sink;
    videosOut = videos.stream;
    getVideos();
  }

  var videos = BehaviorSubject<List<VideoModel>>();
  Observable<List<VideoModel>> videosOut;
  Sink<List<VideoModel>> videosIn;

  void getVideos({String search}) async {
    videosIn.add(null);
    try {
      var response = await repo.getVideos(search: search);
      videosIn.add(response);
    } catch (e) {
      videos.addError(e);
    }
  }

  void dispose() {
    videos.close();
    videosIn.close();
  }
}
