import 'package:http/http.dart' as http;
import 'dart:async';


class StockDataService {
  Future<http.Response> getStockData() async {
    http.Response responseObject;
    await http.get('https://appapi-01-72be8.firebaseio.com/data.json')
    .then((respose) {
      responseObject = respose;
    });
    return responseObject;
  }
}
