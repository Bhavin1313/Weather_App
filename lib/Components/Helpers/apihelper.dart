import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../Model/api_model.dart';

class Api_Helper {
  Api_Helper._();

  static Api_Helper api = Api_Helper._();

  Future<Weather_Model?> fetchWeather({required String search}) async {
    String searchData = search;
    String api =
        "http://api.weatherapi.com/v1/forecast.json?key=3c5009be4d49494f9d245829232208&q=$searchData||surat&days=1&aqi=no&alerts=no";
    http.Response response = await http.get(Uri.parse(api));
    if (response.statusCode == 200) {
      var body = response.body;
      Map decodedata = jsonDecode(body);
      Weather_Model data = Weather_Model.fromJSON(data: decodedata);
      return data;
    } else {
      return null;
    }
  }
}
