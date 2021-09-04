import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'character_segment_map.dart';
import 'segment/segment.dart';
import 'segment_style.dart';
import 'segment_display_painter.dart';

/// Widget responsável por exibir
class SevenSegmentDisplay extends StatelessWidget {
  /// A String que será exibida na tela (Apesar de ser número, é mais facil
  /// manipular String)
  final String value;

  /// Tamanho dos digitos
  final double size;

  /// Estilização dos segmentos
  final SegmentStyle segmentStyle;

  /// Espaço entre os caracteres
  final double characterSpacing = 7.0;

  /// Mapa de valores Hex dos caracteres
  ///
  /// Referencia: [https://qastack.com.br/codegolf/174416/decode-a-7-segment-display]
  final Map<String, int> characterMap = CharacterSegmentMap.numericalDigits;

  SevenSegmentDisplay({
    required this.value,
    SegmentStyle? segmentStyle,
    double? size,
    Color? backgroundColor,
  })  : size = size ?? 10.0,
        segmentStyle = segmentStyle ?? SegmentStyle();

  /// [Size] do segmento
  ///
  /// * [Size.width] representa 'espessura' do segmento
  /// * [Size.height] representa 'comprimento' do segmento
  Size get segmentSize => segmentStyle.segmentBaseSize * size;

  @override
  Widget build(BuildContext context) {
    final _displaySize = computeSize();
    final theme = Theme.of(context);

    return Semantics(
      label: 'Segment display',
      value: value,
      textDirection: TextDirection.ltr,
      child: Container(
        color: theme.scaffoldBackgroundColor,
        child: SizedBox(
          width: _displaySize.width,
          height: _displaySize.height,
          child: CustomPaint(
            size: _displaySize,
            painter: SegmentDisplayPainter(
              segments: createDisplaySegments(),
              enabledColor: segmentStyle.enabledColor,
              disabledColor: segmentStyle.disabledColor,
            ),
          ),
        ),
      ),
    );
  }

  /// Returns `true` when [character] can be displayed on the display.
  bool canDisplay(String character) => characterMap.containsKey(character);

  /// Creates whole display - all characters (all segments)
  List<Segment> createDisplaySegments() {
    final segments = <Segment>[];

    double indent = 0;

    // Add left padding when characterCount > text.length
    for (var i = value.length - value.length; i < value.length; i++) {
      var char = '';
      if (i >= 0 && i < value.length) {
        char = value[i];
      }

      // handle dividers rendering

      final characterSegments = createSingleCharacter(indent);

      // when character can be displayed, enable given segments
      if (char.isNotEmpty && canDisplay(char)) {
        final encoding = characterMap[char];
        for (var i = 0; i < characterSegments.length; i++) {
          if (encoding! >> i & 1 == 1) {
            characterSegments[i].isEnabled = true;
          }
        }
      }

      indent += (2 * segmentSize.width + segmentSize.height) + characterSpacing;
      segments.addAll(characterSegments);
    }

    return segments;
  }

  /// Calcula o tamanho do display que será exibido (A junção dos caracteres)
  Size computeSize() {
    final charCount = value.length;
    final charsWidth = charCount * (2 * segmentSize.width + segmentSize.height);
    final dividersWidth = 0;
    final width = charsWidth + dividersWidth;
    final widthOffset = characterSpacing * (charCount - 1);
    final height = (2 * segmentSize.height) + (3 * segmentSize.width);

    return Size(width + widthOffset, height);
  }

  /// Cria os segmentos para desenhar cada caractere
  /// * Cria apenas UM caractere
  List<Segment> createSingleCharacter(double indent) => [
        Segment.G(segmentStyle, segmentSize, indent),
        Segment.F(segmentStyle, segmentSize, indent),
        Segment.E(segmentStyle, segmentSize, indent),
        Segment.D(segmentStyle, segmentSize, indent),
        Segment.C(segmentStyle, segmentSize, indent),
        Segment.B(segmentStyle, segmentSize, indent),
        Segment.A(segmentStyle, segmentSize, indent),
      ];
}
