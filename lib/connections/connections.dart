import 'dart:convert';

import 'package:app_f/main.dart';
import 'package:app_f/models/pdf_model.dart';
import 'package:http/http.dart' as http;

class RegisterConnection {
  String generalServer = "http://localhost:1337";
  String pathRegister = "/api/auth/local/register";
  String pathLogin = "/api/auth/local";

  Future registerUser({namesAndLastnames, mail, password, city}) async {
    final String url = '$generalServer$pathRegister';

    final Map<String, String> headers = {'Content-Type': 'application/json'};

    final Map<String, dynamic> data = {
      'username': mail,
      'email': mail,
      'password': password,
      'Nombres_Apellidos': namesAndLastnames,
      'Ciudad': city,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        return [true];
      } else {
        print(jsonDecode(response.body));

        return [
          false,
          jsonDecode(response.body)['error']['message'].toString()
        ];
      }
    } catch (error) {
      print(error.toString());
      return [false, error.toString()];
    }
  }

  Future login({mail, password}) async {
    try {
      final String url = '$generalServer$pathLogin';
      final Map<String, String> headers = {'Content-Type': 'application/json'};
      final Map<String, dynamic> data = {
        'identifier': "$mail",
        'password': "$password",
      };
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        sharedPrefsMain!.setString("jwt", jsonDecode(response.body)['jwt']);
        sharedPrefsMain!.setString("nameAndLastname",
            jsonDecode(response.body)['user']['Nombres_Apellidos']);

        return [true];
      } else {
        return [
          false,
          jsonDecode(response.body)['error']['message']
                  .toString()
                  .contains("blocked")
              ? "Cuenta no disponible"
              : jsonDecode(response.body)['error']['message'].toString()
        ];
      }
    } catch (e) {
      return [false, e.toString()];
    }
  }
}

class Connections {
  String generalServer = "http://localhost:1337";

  String pathPdfs = "/api/documentos-pdfs";
  Future getPdfsList() async {
    List<PdfModel> dataTemporal = [];
    try {
      var request = await http.get(
        Uri.parse("$generalServer$pathPdfs?populate=Documento"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer ${sharedPrefsMain!.getString("jwt")}"
        },
      );
      var response = await request.body;
      var decodeData = json.decode(response);
      for (var i = 0; i < decodeData['data'].length; i++) {
        dataTemporal.add(PdfModel(
            title: decodeData['data'][i]['attributes']['Titulo_del_PDF'],
            subtitle: decodeData['data'][i]['attributes']['Descripcion'],
            documentPath: decodeData['data'][i]['attributes']['Documento']
                ['data']['attributes']['url']));
      }
      return dataTemporal;
    } catch (e) {
      return [];
    }
  }
}
