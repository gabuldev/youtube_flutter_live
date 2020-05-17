import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:youtube_api/shared/custom_dio/custom_dio.dart';

import 'app_widget.dart';
import 'modules/home/home_module.dart';
import 'modules/video/video_module.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [Bind((i) => CustomDio())];

  @override
  List<Router> get routers => [
        Router('/', module: HomeModule()),
        Router('/video', module: VideoModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
