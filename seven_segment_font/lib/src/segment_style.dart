import 'dart:ui';

import 'segment/segment_position.dart';

/// Style description that determines color, size (ratio) and shape
/// of [Segment] in [SegmentDisplay].
///
/// To create your own segment style, extend this class and implement
/// [createHorizontalPath], [createVerticalPath] methods.
///
///
/// For example: if you want to change the shape of the top segment in 7-segment
/// display, you can override [createPath7A] method.
/// NOTE: `createPath**` methods use `createHorizontalPath`/`createVerticalPath`/`createDiagonalBackwardPath`/`createDiagonalForwardPath`
/// by default so you don't have to override all `createPath7*` methods.
class SegmentStyle {
  SegmentStyle({
    Size? segmentBaseSize,
    Color? enabledColor,
    Color? disabledColor,
  })  : segmentBaseSize = segmentBaseSize ?? const Size(1.0, 4.0),
        enabledColor = enabledColor ?? const Color(0xffff0000),
        disabledColor =
            enabledColor?.withOpacity(.15) ?? const Color(0x2fff0000);
 
  /// Base size of every segment - used as a size ratio for each segment.
  ///
  /// * [Size.width] represents 'thickness' of segment
  /// * [Size.height] represents 'length' of segment
  ///
  /// Example: Size(1.0, 4.0) basically means that ratio will be 1:4 *(width:length)* (segment will be 1 unit wide/thick and 4 units long).
  ///
  /// NOTE:
  /// [SegmentStyle.segmentBaseSize] * [SegmentDisplay.size] = segmentSize
  final Size segmentBaseSize;

  /// [Color] of every enabled segment.
  final Color enabledColor;

  /// [Color] of every disabled segment.
  final Color disabledColor;

  /// Half Space between neighbouring segments
  final double _halfSpace = 2;

  /// Path dos segmentos horizontais (`-`)
  Path createHorizontalPath(SegmentPosition position, Size segmentSize) {
    final halfWidth = segmentSize.width / 2.0;

    return Path()
      ..moveTo(position.left + _halfSpace, position.top)
      ..lineTo(position.left + segmentSize.height - _halfSpace, position.top)
      ..lineTo(
        position.left + segmentSize.height + halfWidth - _halfSpace,
        position.top + halfWidth,
      )
      ..lineTo(
        position.left + segmentSize.height - _halfSpace,
        position.top + segmentSize.width,
      )
      ..lineTo(position.left + _halfSpace, position.top + segmentSize.width)
      ..lineTo(position.left - halfWidth + _halfSpace, position.top + halfWidth)
      ..close();
  }

  /// Path dos segmentos verticais (`|`)
  Path createVerticalPath(SegmentPosition position, Size segmentSize) {
    final halfWidth = segmentSize.width / 2.0;

    return Path()
      ..moveTo(position.left, position.top + _halfSpace)
      ..lineTo(position.left + halfWidth, position.top - halfWidth + _halfSpace)
      ..lineTo(position.left + segmentSize.width, position.top + _halfSpace)
      ..lineTo(
        position.left + segmentSize.width,
        position.top + segmentSize.height - _halfSpace,
      )
      ..lineTo(
        position.left + halfWidth,
        position.top + segmentSize.height + halfWidth - _halfSpace,
      )
      ..lineTo(position.left, position.top + segmentSize.height - _halfSpace)
      ..close();
  }

  /// Cria o caminho [Path] dos segmentos
  /// Cada letra representa um segmento
  /// Utilize o link para se basear [https://upload.wikimedia.org/wikipedia/commons/thumb/e/ed/7_Segment_Display_with_Labeled_Segments.svg/150px-7_Segment_Display_with_Labeled_Segments.svg.png]

  ///
  Path createPath7A(Size segmentSize, double padding) => createHorizontalPath(
        SegmentPosition.A(segmentSize, padding),
        segmentSize,
      );

  /// Creates path for top right segment in 7-segment display.
  Path createPath7B(Size segmentSize, double padding) => createVerticalPath(
        SegmentPosition.B(segmentSize, padding),
        segmentSize,
      );

  /// Creates path for bottom right segment in 7-segment display.
  Path createPath7C(Size segmentSize, double padding) => createVerticalPath(
        SegmentPosition.C(segmentSize, padding),
        segmentSize,
      );

  /// Creates path for bottom segment in 7-segment display.
  Path createPath7D(Size segmentSize, double padding) => createHorizontalPath(
        SegmentPosition.D(segmentSize, padding),
        segmentSize,
      );

  /// Creates path for bottom left segment in 7-segment display.
  Path createPath7E(Size segmentSize, double padding) => createVerticalPath(
        SegmentPosition.E(segmentSize, padding),
        segmentSize,
      );

  /// Creates path for top left segment in 7-segment display.
  Path createPath7F(Size segmentSize, double padding) => createVerticalPath(
        SegmentPosition.F(segmentSize, padding),
        segmentSize,
      );

  /// Creates path for middle segment in 7-segment display.
  Path createPath7G(Size segmentSize, double padding) => createHorizontalPath(
        SegmentPosition.G(segmentSize, padding),
        segmentSize,
      );
}
