import 'dart:ui';

/// Posição dos segmentos no display
class SegmentPosition {
  /// Offset from left.
  final double left;

  /// Offset from top.
  final double top;

  /// Creates [SegmentPosition] with [left] and [top] offset.
  const SegmentPosition(this.left, this.top);

  /// Creates [SegmentPosition] for decimal point segment.
  SegmentPosition.decimalPoint(Size size, double padding)
      : this(padding, 2 * size.width + 2 * size.height);

  /// Creates [SegmentPosition] for colon segment.
  SegmentPosition.colon(Size size, double padding)
      : this(padding, size.height / 2 + size.width / 2);

  /// Creates [SegmentPosition] for top segment in 7Ssegment display.
  SegmentPosition.A(Size size, double padding)
      : this(size.width + padding, 0.0);

  /// Creates [SegmentPosition] for top right segment in 7Ssegment display.
  SegmentPosition.B(Size size, double padding)
      : this(size.width + size.height + padding, size.width);

  /// Creates [SegmentPosition] for bottom right segment in 7Ssegment display.
  SegmentPosition.C(Size size, double padding)
      : this(size.width + size.height + padding, 2 * size.width + size.height);

  /// Creates [SegmentPosition] for bottom segment in 7Ssegment display.
  SegmentPosition.D(Size size, double padding)
      : this(size.width + padding, 2 * size.width + 2 * size.height);

  /// Creates [SegmentPosition] for bottom left segment in 7Ssegment display.
  SegmentPosition.E(Size size, double padding)
      : this(padding, 2 * size.width + size.height);

  /// Creates [SegmentPosition] for top left segment in 7Ssegment display.
  SegmentPosition.F(Size size, double padding) : this(padding, size.width);

  /// Creates [SegmentPosition] for middle segment in 7Segment display.
  SegmentPosition.G(Size size, double padding)
      : this(size.width + padding, size.width + size.height);

}