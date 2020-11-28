import 'package:flutter/material.dart';

class KCirleIndicatorRefresh extends StatelessWidget {
  final Color color;
  final EdgeInsets margin;
  final double strokeWidth;
  final EdgeInsets padding;
  const KCirleIndicatorRefresh({
    Key key,
    this.margin,
    this.padding,
    this.strokeWidth = 4,
    @required this.color,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 44,
        height: 44,
        margin: this.margin,
        padding: this.padding,
        child: CircularProgressIndicator(
          strokeWidth: this.strokeWidth,
          valueColor: AlwaysStoppedAnimation<Color>(this.color),
        ),
      ),
    );
  }
}
