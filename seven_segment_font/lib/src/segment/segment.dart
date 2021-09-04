import 'dart:ui';

import '../segment_style.dart';

/// Cada segmento do digito.
class Segment {

  Segment({
    required this.path,
    this.isEnabled = false,
  });

  /// Diz ao Drawer como desenhar o segmento (O caminho ou forma do segmento)
  Path path;

  /// Estado do segmento (Ativado / Desativado)
  bool isEnabled;


  /// Cria o segmento superior
  Segment.A(SegmentStyle style, Size segmentSize, double padding)
      : this(path: style.createPath7A(segmentSize, padding));

  /// Cria o segmento superior direito
  Segment.B(SegmentStyle style, Size segmentSize, double padding)
      : this(path: style.createPath7B(segmentSize, padding));

  /// Cria o segmento inferior direito
  Segment.C(SegmentStyle style, Size segmentSize, double padding)
      : this(path: style.createPath7C(segmentSize, padding));

  /// Cria o segmento inferior
  Segment.D(SegmentStyle style, Size segmentSize, double padding)
      : this(path: style.createPath7D(segmentSize, padding));

  /// Cria o segmento inferior esquerdo
  Segment.E(SegmentStyle style, Size segmentSize, double padding)
      : this(path: style.createPath7E(segmentSize, padding));

  /// Cria o segmento superior esquerdo
  Segment.F(SegmentStyle style, Size segmentSize, double padding)
      : this(path: style.createPath7F(segmentSize, padding));

  /// Cria o segmento central
  Segment.G(SegmentStyle style, Size segmentSize, double padding)
      : this(path: style.createPath7G(segmentSize, padding));

}