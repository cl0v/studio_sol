import '../interfaces/http_client_interface.dart';

import 'game_model.dart';
import '../utils/simple_bloc.dart';


/// Controlador da página que acontece o jogo.
/// 
/// Chame o metodo [onNewGamePressed] no inicio e toda vez que quiser iniciar
/// uma nova rodada.
/// 
/// Chame o metodo [onGuessPressed] toda vez que quiser tentar adivinhar um
/// novo valor.


class GameController {
  GameController(this.httpService) {
    onNewGamePressed();
  }

  /// Serviço que controla a requisição http.
  /// É recebido por injeção de dependencia. (Modelo simplificado)
  final IHttpClient httpService;

  /// Valor que que o usuário tentará adivinhar (Atualiza a cada rodada).
  int _value = 0;

  /// Modelo salvo em cache apenas para quando dá um erro ele salvar o resultado da ultima tentativa.
  /// Para funcionar normalmente
  GameModel _cachedModel = GameModel(0, null, false, false);

  /// O Bloc, que é basicamente o que controla o estado do app por Stream e é
  /// uma excelente alternativa de controle de estado, pois não precisa do 
  /// setState. (Apesar de que deixei exemplos do setState na View)
  SimpleBloc<GameModel> _guessBloc = SimpleBloc();
  Stream<GameModel> get guess => _guessBloc.stream;

  /// Metodo chamado quando o botão de "Nova partida" é apertado
  onNewGamePressed() async {
    // _guessBloc.add(GameModel(0, null, false, true)); // Descomentar.
    _guessBloc.add(await _newGameModel());
  }

  /// Recebe a resposta e comunica com o usuário
  /// - "É menor": quando o palpite enviado é m​ aior​ que o número obtido
  /// - "É maior": quando o palpite enviado é m​ enor​ que o número obtido
  /// - "Acertou!": quando o palpite enviado é igual ao número obtido
  ///
  /// Esse metodo também é responsável por adicionar o novo modelo (estado atual)
  /// Além de salvar o novo modelo em cache (Recuperado ao encontrar erro).
  onGuessPressed(int guess) {
    late String _hint;
    bool win = false;

    if (guess < _value) {
      _hint = "É maior";
    } else if (guess > _value) {
      _hint = "É menor";
    } else {
      _hint = "Acertou!";
      win = true;
    }

    final model = GameModel(guess, _hint, win, !win);

    _guessBloc.add(model);
    _cachedModel = model;
  }

  /// Recebe o novo valor randomico, ou comunica que houve um erro para o usuário
  /// - "Erro": quando houver erro na requisição
  Future<GameModel> _newGameModel([min = 1, max = 300]) async {
    var url =
        'https://us-central1-ss-devops.cloudfunctions.net/rand?min=$min&max=$max';
    final value = await httpService.get(url);
    print('O novo valor é : $value');
    _value = value ?? _cachedModel.guess;

    return value == null
        ? GameModel(0, 'Erro', true, false)
        : GameModel(0, null, false, true);
  }

  /// Sempre bom usar dispose quando se trabalha com streams.
  dispose() {
    _guessBloc.dispose();
  }
}
