import 'dart:async';


/// Forma simplificada de usar Streams =D
/// Se quiserem user esse modelo friendly do Bloc que criei, fiquem a vontade...
class SimpleBloc<T> {

  final _controller = StreamController<T>();

  Stream<T> get stream => _controller.stream;

  /// Adiciona um valor a stream.
  add(T obj) {
    if (!_controller.isClosed) {
      _controller.add(obj);
    }
  }
  
  /// Sempre se lembre de chamar o dispose para não ter problemas.
  dispose() {
    _controller.close();
  }
  
  // /// Sobrescreve a outra stream, util para conexões com servidor.
  // subscribe(Stream<T> s) {
  //   if (!_controller.isClosed) {
  //     s.listen((v) => add(v));
  //   }
  // }

  // /// Adiciona um erro à stream. Util para exibir erros para o usuário.
  // addError(Object obj) {
  //   if (!_controller.isClosed) {
  //     _controller.addError(obj);
  //   }
  // }
}