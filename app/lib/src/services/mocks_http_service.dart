
// ! Não está sendo usada, apenas para refêrencia

/// Existem abordagens melhores e até mais simples para se testar esse tipo
/// de serviço, porém nesse caso fica mais evidente e intuitivo para caso
/// vocês não avaliem os testes da metodologia TDD.

abstract class IHttpClient {
 Future<Map<String, dynamic>> get(String url);
}

/// Mock da HttpServices em que o get sempre retornará com sucesso.
class MockedHttpService implements IHttpClient {
  @override
  Future<Map<String, dynamic>> get(String url) async {
    return {
      "value": 15,
    };
  }
}

/// Mock da HttpServices em que o get sempre retornará com falha.
class MockExceptionHttpService implements IHttpClient {
  @override
  Future<Map<String, dynamic>> get(String url) async {
    return {"Error": "Bad Gateway", "StatusCode": 502};
  }
}
