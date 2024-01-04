import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future loginUser(String email, String password) async {
  String url = 'https://malabusfront1.onrender.com/user/loginMobile';

  Uri url2 = Uri.parse(url);
  try {
    final response = await http.post(url2,
        headers: {"Content-Type": "application/json; charset=UTF-8"},
        body: json.encode({'email': email, 'password': password}));
    //var convertedJson = json.decode(response.body);
    return response;
  } catch (e) {
    // print(e);
  }
}

Future registerUser(
    String nom,
    String prenom,
    String username,
    String datenaiss,
    String tel,
    String email,
    String password,
    String fonction,
    String civilite,
    String adresse,
    String codepostal,
    String ville,
    String pays) async {
  String url = 'https://malabusfront1.onrender.com/user/registerMobile';

  Uri url2 = Uri.parse(url);
  try {
    final response = await http.post(url2,
        headers: {"Content-Type": "application/json; charset=UTF-8"},
        body: json.encode({
          "fname": nom,
          "lname": prenom,
          "username": username,
          "birthday": datenaiss,
          "phoneNum": tel,
          "email": email,
          "password": password,
          "job": fonction,
          "civility": civilite,
          "address": adresse,
          "postalCode": codepostal,
          "city": ville,
          "country": pays
        }));

    return response;
  } catch (e) {
    // print(e);
  }
}

Future forgetPassword(String email) async {
  String url = 'https://malabusfront1.onrender.com/user/forgetpasword';

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

Future sendSms(String phoneNumber) async {
  String url = 'https://malabusfront1.onrender.com/user/sms';

  Uri url2 = Uri.parse(url);
  try {
    final response = await http.post(url2,
        headers: {"Content-Type": "application/json; charset=UTF-8"},
        body: json.encode({'phoneNum': phoneNumber}));
    //var convertedJson = json.decode(response.body);
    // print(response);
    return response;
  } catch (e) {
    //  print(e);
  }
}

Future test() async {
  String url = 'https://malabusfront1.onrender.com/user/test';

  Uri url2 = Uri.parse(url);
  try {
    final response = await http.post(
      url2,
      headers: {"Content-Type": "application/json; charset=UTF-8"},
      //body: json.encode({'phoneNum': phoneNumber})
    );
    //var convertedJson = json.decode(response.body);
    //print('////////////');
    //print(response);
    // print('////////////');
    return response;
  } catch (e) {
    // print(e);
  }
}

Future verifyUser(
    String nom,
    String prenom,
    String username,
    String datenaiss,
    String tel,
    String email,
    String password,
    String fonction,
    String civilite,
    String adresse,
    String codepostal,
    String ville,
    String pays) async {
  String url = 'https://malabusfront1.onrender.com/user/verify';

  Uri url2 = Uri.parse(url);
  try {
    final response = await http.post(url2,
        headers: {"Content-Type": "application/json; charset=UTF-8"},
        body: json.encode({
          "fname": nom,
          "lname": prenom,
          "username": username,
          "birthday": datenaiss,
          "phoneNum": tel,
          "email": email,
          "password": password,
          "job": fonction,
          "civility": civilite,
          "address": adresse,
          "postalCode": codepostal,
          "city": ville,
          "country": pays
        }));

    return response;
  } catch (e) {
    // print(e);
  }
}

Future getProfil() async {
  final prefs = await SharedPreferences.getInstance();
  final String? id = prefs.getString('userId');
  String url = 'https://malabusfront1.onrender.com/user/getProfilMobile/' + id!;

  Uri url2 = Uri.parse(url);
  try {
    final response = await http.get(
      url2,
      headers: {"Content-Type": "application/json; charset=UTF-8"},
    );
    //var convertedJson = json.decode(response.body);
    return response;
  } catch (e) {
    //print(e);
  }
}

Future updateProfil(
  String nom,
  String prenom,
  String datenaiss,
  String tel,
  String email,
  String fonction,
  String civilite,
  String adresse,
) async {
  final prefs = await SharedPreferences.getInstance();
  final String? id = prefs.getString('userId');
  String url = 'https://malabusfront1.onrender.com/user/updateProfilMobile/' + id!;

  Uri url2 = Uri.parse(url);
  try {
    final response = await http.put(url2,
        headers: {"Content-Type": "application/json; charset=UTF-8"},
        body: json.encode({
          "fname": nom,
          "lname": prenom,
          "birthday": datenaiss,
          "phoneNum": tel,
          "email": email,
          "job": fonction,
          "civility": civilite,
          "address": adresse
        }));
    //var convertedJson = json.decode(response.body);
    return response;
  } catch (e) {
    // print(e);
  }
}
