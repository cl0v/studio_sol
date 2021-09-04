import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:studio_sol_app/src/interfaces/http_client_interface.dart';


/// Serviço de requisições HTTP utilizando a biblioteca padrão do dart.
/// 
class HttpService implements IHttpClient {
  @override
  Future<int?> get(String url) async {
    try {
      final uri = Uri.parse(url);
      final response = await http.Client().get(uri);
      var jsonResponse = jsonDecode(response.body);
      return jsonResponse['value'];
    } catch (e) {}
  }
}


/*
URL: https://us-central1-ss-devops.cloudfunctions.net/rand?min=1&max=300
Status: 502
Source: Network
Address: 216.239.36.54:443

r: {"Error": "Bad Gateway","StatusCode": 502 }

URL: https://us-central1-ss-devops.cloudfunctions.net/rand?min=1&max=300
Status: 200
Source: Network
Address: 216.239.36.54:443
*/