import 'dart:convert';
import 'package:http/http.dart' as http;

Future registerAgency(
  String nom,
  String matricule,
  String numcnss,
  String statutlegale,
  String secteuractivite,
  String email,
) async {
  String url = 'https://malabusfront1.onrender.com/agency/register';

  Uri url2 = Uri.parse(url);
  try {
    final response = await http.post(url2,
        headers: {"Content-Type": "application/json; charset=UTF-8"},
        body: json.encode({
          'nameagency': nom,
          'matricule': matricule,
          'num_cnss': numcnss,
          'business_sector': secteuractivite,
          'legal_status': statutlegale,
          'email': email,
        }));
    //var convertedJson = json.decode(response.body);
    return response;
  } catch (e) {
    print(e);
  }
}

Future loginAgency(
  String password,
  String email,
) async {
  String url = 'https://malabusfront1.onrender.com/agency/login';

  Uri url2 = Uri.parse(url);
  try {
    final response = await http.post(url2,
        headers: {"Content-Type": "application/json; charset=UTF-8"},
        body: json.encode({
          'credentels': email,
          'password': password,
        }));
    //var convertedJson = json.decode(response.body);
    return response;
  } catch (e) {
    // print(e);
  }
}

Future forgetPassword(String email) async {
  String url = 'https://malabusfront1.onrender.com/agency/forgetpassword';

  Uri url2 = Uri.parse(url);
  try {
    final response = await http.post(url2,
        headers: {"Content-Type": "application/json; charset=UTF-8"},
        body: json.encode({'email': email}));
    //var convertedJson = json.decode(response.body);
    return response;
  } catch (e) {
    // print(e);
  }
}
