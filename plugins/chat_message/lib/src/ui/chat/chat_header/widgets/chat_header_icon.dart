import 'package:flutter/material.dart';

class KChatHeaderIcon extends StatelessWidget {
  final String? icon;
  final double? width;
  final double? height;
  final Function()? onTap;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  const KChatHeaderIcon({
    Key? key,
    this.icon,
    this.width,
    this.onTap,
    this.height,
    this.margin,
    this.padding,
    this.backgroundColor,
  })  : assert(icon != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        margin: margin,
        padding: padding,
        child: Image(
          image: AssetImage(icon!),
        ),
      ),
    );
  }
}
