import 'dart:convert';
import 'package:http/http.dart' as http;

Future arretLatLong(
  String idVoyage,
  String arretDepart,
  String arretArrive,
) async {
  String url = 'https://malabusfront1.onrender.com/user/arretCordinate';

  Uri url2 = Uri.parse(url);
  try {
    final response = await http.post(url2,
        headers: {"Content-Type": "application/json; charset=UTF-8"},
        body: json.encode({
          'id_Voyage': idVoyage,
          'arretDepart': arretDepart,
          'arretArrive': arretArrive,
        }));
    //var convertedJson = json.decode(response.body);
    return response;
  } catch (e) {
    // print(e);
  }
}

Future getAll() async {
  String url = 'https://malabusfront1.onrender.com/station/listearret';

  Uri url2 = Uri.parse(url);
  try {
    final response = await http.get(
      url2,
      headers: {"Content-Type": "application/json; charset=UTF-8"},
    );
    //var convertedJson = json.decode(response.body);
    return response;
  } catch (e) {
    // print(e);
  }
}
