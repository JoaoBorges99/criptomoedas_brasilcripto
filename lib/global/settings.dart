import 'package:flutter_dotenv/flutter_dotenv.dart';

class Settings {

  static final String urlApi = dotenv.get('URL_API');
  static final String apiKey = dotenv.get('API_KEY');

  static Future<Map> getRequest () async {
    return {};
  }

}