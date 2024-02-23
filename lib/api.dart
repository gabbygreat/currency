import 'package:dio/dio.dart';

import 'model.dart';

Future<Temperatures> getCurrentPrice() async {
  var path = "https://api.coindesk.com/v1/bpi/currentprice.json";

  var dio = Dio();
  var request = await dio.get(path);
  return Temperatures.fromJson(request.data);
}
