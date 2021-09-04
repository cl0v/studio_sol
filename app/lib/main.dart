import 'package:flutter/material.dart';
import 'package:sol_design_system/sol_design_system.dart';
import 'package:studio_sol_app/src/game/game_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Studio Sol Comunicação',
      debugShowCheckedModeBanner: false,
      theme: themeLight,
      home: GamePage(),
    );
  }
}

/*
● (x) Compila e executa sem crashes
● (x) Descrição do funcionamento do programa (deve condizer com o que foi
implementado)
● (x) Implementação da requisição e tratamento correto dos possíveis status
● (x) Tratamento correto do input do usuário 
● (x) Funcionamento correto e robustez da solução
● (x) Controle de estado do botão NOVA PARTIDA
● (x) Layout condizente com os exemplos 
● (x) Organização e clareza do código
*/

/*
★ Tamanho do segmento de LED (2 pts)​:
● (x) Você deve dar suporte a no mínimo 5 tamanhos distintos para os números de LED.
● (x) Android e iOS: Exibir um ​slider​ quando o ícone de tamanho de texto for clicado.

Cores nos leds (2 pts)​:
● (x) Você pode utilizar qualquer biblioteca disponível na Internet para solução de paleta de cores.
● (x) A paleta de cores precisa aparecer assim que o ícone correspondente for clicado.
● (x) Os segmentos devem ser atualizados assim que uma cor for tocada na paleta de cores.
● (x) O componente da paleta deve ser fechado quando qualquer área fora da paleta for clicada.
*/