import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

Future findVoyage(String depart, String arrive, String datevoyage) async {
  String url = 'https://malabusfront1.onrender.com/user/recherche_voyage';

  Uri url2 = Uri.parse(url);
  try {
    final response = await http.post(url2,
        headers: {"Content-Type": "application/json; charset=UTF-8"},
        body: json.encode({
          'arretDepart': depart,
          'arretArrive': arrive,
          'dateVoyage': datevoyage
        }));
    //var convertedJson = json.decode(response.body);
    return response;
  } catch (e) {
    debugPrint('movieTitle:');
    // print(e);
  }
}
