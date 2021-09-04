import 'package:dependency_module/dependency_module.dart';
import 'package:studio_sol_app/src/interfaces/http_client_interface.dart';

// ! Essa solução do dio não está sendo usada. É apenas uma demonstração da interface.

/// Http Service utilizando a biblioteca Dio
class DioService implements IHttpClient {
  final Dio dio = Dio();

  @override
  Future<int?> get(String url) async {
    try {
      var response = await dio.get(url);
      return response.data['value'];
    } catch (e) {
      return null;
    }
  }
}


