/// Interface responsável por garantir o funcionamento da requisição HTTP.
/// Interface do serviço do Http Request
/// (Adaptado para a simplicidade da aplicação)
abstract class IHttpClient {
  /// Recebe um [int] com o valor retornado na response da url fornecida.
  /// * Em casos de falha será retornado um null.
  /// 
  /// Não implementei uma tratativa mais robusta for sake of simplicity.
  /// Porém vou deixar uma tratativa na pasta de utilidades, pra servir de
  /// referência no diretório:  [utils/custom_exception.dart]
  Future<int?> get(String url);
}