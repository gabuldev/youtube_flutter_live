import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:youtube_api/app/modules/home/home_bloc.dart';
import 'package:youtube_api/app/modules/home/home_page.dart';
import 'package:youtube_api/app/modules/home/home_repository.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => HomeRepository(i.get<Dio>())),
        Bind((i) => HomeBloc(i.get<HomeRepository>()))
      ];

  @override
  List<Router> get routers => [
        Router(
          "/",
          child: (context, args) => HomePage(),
        )
      ];

  static Inject get to => Inject<HomeModule>.of();
}
