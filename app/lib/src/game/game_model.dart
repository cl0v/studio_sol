

/// [GameModel] é o modelo que guarda o estado atual das tentativas do usuário.
/// 
/// É apenas um facilitador, para trabalhar com o Bloc, o que torna o código
/// muito mais limpo.

class GameModel {
  GameModel(
    this.guess,
    this.hint, [
    this.isNewRoundVisible = false,
    this.isSendBtnAvailable = true,
  ]);

  /// Valor de chute
  int guess;

  /// Dica informando
  /// - "É menor": quando o palpite enviado é m​ aior​ que o número obtido
  /// - "É maior": quando o palpite enviado é m​ enor​ que o número obtido
  /// - "Acertou!": quando o palpite enviado é igual ao número obtido
  /// Nota: Caso seja nulo, o texto ficará com visibilidade escondida
  String? hint;

  /// Visibilidade do botão de NOVA RODADA
  bool isNewRoundVisible;

  /// Disponibilidade do botão de ENVIAR
  bool isSendBtnAvailable;
}
