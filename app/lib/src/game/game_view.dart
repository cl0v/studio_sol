import 'package:dependency_module/dependency_module.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:seven_segment_font/seven_segment_font.dart';

import 'game_controller.dart';
import 'game_model.dart';
import '../services/client_http_service.dart';

/// Página em que acontecerá toda a parte visual e interativa do jogo.
///
/// O [_GamePanel] é o output responsável por exibir as informações para o
/// usuário sempre que ele interagir com o aplicativo.
/// O botão 'Nova Partida também está presente nesse Widget.
///
/// O [_GuessButtonField] é o input responsável por isolar a responsábilidade
/// de fazer uma nova tentativa.
/// 
/// O [_CustomSlider] é o Widget auxiliar para aumentar ou diminuir o tamanho
/// da 'fonte' do 7Segment

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  /// textController do valor digitado.
  TextEditingController valueController = TextEditingController();

  /// Controllador do Jogo
  late final GameController controller;


  /// Current color of the digits
  late Color _currentColor;

  /// Tamanho inicial do 7Segment [4 ... 16]
  double segmentSize = 10;

  /// Utilize [SegmentStyle] para controlar as cores do 7Segment
  SegmentStyle get segmentStyle => SegmentStyle(
        enabledColor: _currentColor,
      );

  /// Função que atualiza a cor dos segmentos
  onChangeColor(Color color) {
    setState(() => _currentColor = color);
  }

  /// Função que atualiza o tamanho dos segmentos
  onSizeChanged(double value) {
    setState(() => segmentSize = value);
  }

  @override
  void initState() {
    controller = GameController(HttpService());
    super.initState();
  }

  /// didChangeDependencies precisa ser chamado quando utiliza uma subclasse do
  /// InheritedWidget e quer utilizar algum parametro dessa subclasse.
  @override
  void didChangeDependencies() {
    _currentColor = Theme.of(context).primaryColor;
    super.didChangeDependencies();
  }

  /// Se for trabalhar com Stream sempre chame o dispose na página (Libera a
  /// stream da memoria).
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Qual é o número?'),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (c) => AlertDialog(
                  content: _CustomSlider(
                      initialValue: segmentSize, onChanged: onSizeChanged),
                ),
              );
            },
            icon: Icon(Icons.text_fields),
          ),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (c) => AlertDialog(
                  content: MaterialColorPicker(
                    onColorChange: onChangeColor,
                    selectedColor: _currentColor,
                  ),
                ),
              );
            },
            icon: Icon(Icons.color_lens_sharp),
          )
        ],
      ),
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 12),
        child: Center(
          child: StreamBuilder<GameModel>(
              stream: controller.guess,
              builder: (context, snapshot) {
                final model = snapshot.data ?? GameModel(0, null, false);

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _GamePanel(
                      model: model,
                      controller: controller,
                      segmentSize: segmentSize,
                      segmentStyle: segmentStyle,
                    ),
                    _GuessButtonField(
                      valueController: valueController,
                      model: model,
                      controller: controller,
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}

/// Painel que exibe o resultado (Output) para o usuário.
/// Incluindo as dicas e o valor arriscado.
class _GamePanel extends StatelessWidget {
  const _GamePanel({
    required this.model,
    required this.segmentSize,
    required this.controller,
    required this.segmentStyle,
  });

  final GameModel model;
  final double segmentSize;
  final GameController controller;
  final SegmentStyle segmentStyle;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 2,
      child: Column(
        children: [
          Visibility(
            visible: model.hint != null,
            child: Text(model.hint ?? ''),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: SevenSegmentDisplay(
              size: segmentSize,
              value: model.guess.toString(),
              segmentStyle: segmentStyle,
            ),
          ),

          /// Existe a possibilidade desse valor demorar um pouco e a pessoa
          /// clicar duas vezes no botao, para solucionar esse 'Bug', basta,
          /// no game_controller, no metodo onNewGamePressed, descomentar
          /// a primera linha
          Visibility(
            visible: model.isNewRoundVisible,
            child: ElevatedButton(
              onPressed: controller.onNewGamePressed,
              child: Text('Nova Partida'),
            ),
          )
        ],
      ),
    );
  }
}

/// Campo e botão de tentativa (Input) para o usuário arriscar um valor.
class _GuessButtonField extends StatelessWidget {
  const _GuessButtonField(
      {Key? key,
      required this.valueController,
      required this.model,
      required this.controller})
      : super(key: key);

  final TextEditingController valueController;
  final GameModel model;
  final GameController controller;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        children: [
          Expanded(
            child: TextField(
              maxLength: 3,
              decoration: InputDecoration(hintText: 'Digite o palpite'),
              controller: valueController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ),
          ElevatedButton(
            onPressed: model.isSendBtnAvailable
                ? () {
                    controller.onGuessPressed(int.parse(valueController.text));
                    valueController
                        .clear(); // Limpa o campo pros senhores. Caso não queiram, basta apagar essa linha
                  }
                : null,
            child: Text('ENVIAR'),
          ),
        ],
      ),
    );
  }
}

/// Slider customizado para facilitar a chamada do setState
/// Geralmente isolar pequenos componentes facilita a manutenção / Reutilização
/// e testabilidade
class _CustomSlider extends StatefulWidget {
  const _CustomSlider(
      {required this.initialValue, required this.onChanged, Key? key})
      : super(key: key);
  final Function(double value) onChanged;
  final double initialValue;

  @override
  __CustomSliderState createState() => __CustomSliderState();
}

class __CustomSliderState extends State<_CustomSlider> {
  double _currentSliderValue = 10;

  @override
  void initState() {
    _currentSliderValue = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Slider(
          value: _currentSliderValue,
          min: 4,
          max: 16,
          divisions: 6,
          label: _currentSliderValue.round().toString(),
          onChanged: (double value) {
            setState(() {
              _currentSliderValue = value;
              widget.onChanged(value);
            });
          },
        ),
      ],
    );
  }
}
