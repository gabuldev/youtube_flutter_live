import 'package:flutter_modular/flutter_modular.dart';
import 'package:youtube_api/app/modules/video/video_page.dart';

class VideoModule extends ChildModule {
  @override
  List<Bind> get binds => [];

  @override
  List<Router> get routers => [
        Router(
          "/:id",
          child: (context, args) => VideoPage(
            idVideo: args.params["id"],
          ),
        )
      ];

  static Inject get to => Inject<VideoModule>.of();
}
