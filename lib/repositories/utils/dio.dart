import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:home_tasks_app/repositories/utils/token_controller.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@singleton
class MyDio {
  late Dio dio;
  Future<void> init(TokenController tokenController) async {
    dio = Dio();

    (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () =>
        HttpClient()
          ..badCertificateCallback =
              (X509Certificate cert, String host, int port) => true;

              
    dio.options.connectTimeout =
        const Duration(seconds: 5); //таймаут на отправление
    dio.options.receiveTimeout =
        const Duration(seconds: 5); //таймаут на получение
    dio.options.baseUrl = "https://192.168.10.102:7119/api/";
    dio.interceptors.add(PrettyDioLogger(
      requestBody: true,
    )); //дефолтый адрес(писать один раз!!!)
    dio.interceptors.add(InterceptorsWrapper(
      onError: (error, handler) async {
        if (error.response?.statusCode == 401) {
          await tokenController.refreshToken(dio); //обработка refresh
          final opts = Options(
              //копирование параметров предыдущего запроса для его повторения
              method: error.requestOptions.method,
              headers: error.requestOptions.headers);
          final cloneReq = await dio.request(error.requestOptions.path,
              options: opts,
              data: error.requestOptions.data,
              queryParameters: error.requestOptions.queryParameters);

          return handler.resolve(cloneReq); //повторение запроса
        }

        return handler.next(error);
      },
    ));
  }
}
