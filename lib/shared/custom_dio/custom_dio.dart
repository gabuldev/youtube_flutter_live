import 'package:dio/native_imp.dart';

class CustomDio extends DioForNative {
  CustomDio() {
    options.baseUrl = "https://www.googleapis.com/youtube/v3";
    /*interceptors.add(
        InterceptorToken(token: () async => AuthBloc.getInstance().getJWT()));*/
  }
}
