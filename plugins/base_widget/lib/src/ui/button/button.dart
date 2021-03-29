import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  /// The color to paint behind the [child].
  ///
  /// This property should be preferred when the background is a simple color.
  /// For other cases, such as gradients or images, use the [decoration]
  /// property.
  ///
  final Color? color;

  /// the disable press [Button]
  final bool disable;

  /// the [width] of Button
  final double? width;

  /// The [child] contained by the Button.
  final Widget? child;

  /// the [height] of Button
  final double? height;

  /// the color to paint line of border
  final Color borderColor;

  /// Empty space to surround the [decoration] and [child].
  final EdgeInsets? margin;

  /// Empty space to inscribe inside the [Button]. The [child], if any, is
  /// placed inside this padding.
  ///
  /// This padding is in addition to any padding inherent in the [decoration];
  /// see [Decoration.padding].
  final EdgeInsets? padding;

  /// Align the [child] within the container.
  ///
  /// If non-null, the container will expand to fill its parent and position its
  /// child within itself according to the given value. If the incoming
  /// constraints are unbounded, then the child will be shrink-wrapped instead.
  ///
  /// Ignored if [child] is null.
  ///
  /// See also:
  ///
  ///  * [Alignment], a class with convenient constants typically used to
  ///    specify an [AlignmentGeometry].
  ///  * [AlignmentDirectional], like [Alignment] for specifying alignments
  ///    relative to text direction.
  final Alignment? alignment;

  /// Called when the button is tapped or otherwise activated.
  final Function()? onCallback;

  /// A list of shadows cast by this box behind the box.
  ///
  /// The shadow follows the [shape] of the box.
  ///
  /// See also:
  ///
  ///  * [kElevationToShadow], for some predefined shadows used in Material
  ///    Design.
  ///  * [PhysicalModel], a widget for showing shadows.
  final List<BoxShadow>? boxShadow;

  /// The border radius of the rounded corners.
  ///
  /// Values are clamped so that horizontal and vertical radii sums do not
  /// exceed width/height.
  ///
  /// This value is ignored if [clipper] is non-null.
  final BorderRadius? borderRadius;

  const Button({
    Key? key,
    this.color,
    this.width,
    this.child,
    this.height,
    this.padding,
    this.boxShadow,
    this.alignment,
    this.onCallback,
    this.disable = false,
    this.margin = EdgeInsets.zero,
    this.borderRadius = BorderRadius.zero,
    this.borderColor = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      height: this.height,
      margin: this.margin,
      padding: this.padding,
      decoration: BoxDecoration(
        boxShadow: this.boxShadow,
        borderRadius: this.borderRadius,
        border: Border.all(color: this.borderColor),
      ),
      child: IgnorePointer(
        ignoring: this.disable,
        child: ClipRRect(
          borderRadius: this.borderRadius,
          child: RawMaterialButton(
            fillColor: this.color,
            onPressed: this.onCallback,
            child: Container(
              width: this.width,
              child: this.child,
              height: this.height,
              alignment: this.alignment,
            ),
          ),
        ),
      ),
    );
  }
}
