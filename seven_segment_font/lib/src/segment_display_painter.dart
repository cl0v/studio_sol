import 'package:flutter/widgets.dart';
import 'segment/segment.dart';

/// Utiliza um [CustomPainter] para desenhar os segmentos.
///
/// [PaintingStyle.fill] é o responsável por preencher após traçar o Path.
class SegmentDisplayPainter extends CustomPainter {
  /// [Paint] style para desenhar os segmentos quando 'ativos'.
  late Paint _enabledPaint;

  /// [Paint] style para desenhar os segmentos quando 'desativos'.
  late Paint _disabledPaint;

  /// Lista de todos os segmentos que deverão ser desenhados.
  /// Literalmente os 7 segmentos, incluindo os desativados.
  List<Segment> segments;

  final _enabledPath = Path();
  final _disabledPath = Path();

  /// Cria o [SegmentDisplayPainter], responsável por definir os segmentos.
  /// * O parametro [enabledColor] representa a cor quando ativado
  /// * O parametro [disabledColor] representa a cor quando ativado
  ///
  SegmentDisplayPainter({
    required this.segments,
    required Color enabledColor,
    required Color disabledColor,
  }) {
    _enabledPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = enabledColor;

    _disabledPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = disabledColor;

    for (final segment in segments) {
      if (segment.isEnabled) {
        _enabledPath.addPath(segment.path, Offset.zero);
      } else {
        _disabledPath.addPath(segment.path, Offset.zero);
      }
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height));
    canvas.drawPath(_enabledPath, _enabledPaint);
    canvas.drawPath(_disabledPath, _disabledPaint);
  }

  @override
  bool shouldRepaint(SegmentDisplayPainter oldDelegate) {
    return segments != oldDelegate.segments;
  }
}
