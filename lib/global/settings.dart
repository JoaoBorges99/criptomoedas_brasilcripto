import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Settings {

  static final String urlApi = dotenv.get('URL_API');
  static final String apiKey = dotenv.get('API_KEY');

  static Future<List> getRequest ({String editUrl = ''}) async {
    try {
      final Uri url = Uri.parse(urlApi+apiKey+editUrl);
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if(jsonData['data'] == null) {
          throw Exception('Erro ao buscar dados: ${jsonData['error']}');
        }
        final List data = jsonData['data'];

        return data;

      } else {
        throw Exception('Erro de API: ${response.statusCode}');
      }
    } catch (e) {
      print('Erro ao buscar dados: $e');
      return [];
    }
  }

}