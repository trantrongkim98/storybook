import 'package:flutter/material.dart';

class PlayPauseButton extends StatefulWidget {
  final double width;
  final double height;
  final String iconPlay;
  final String iconPause;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Function(bool) onStateChanged;

  const PlayPauseButton({
    Key key,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.iconPlay,
    this.iconPause,
    this.onStateChanged,
  }) : super(key: key);
  @override
  _PlayPauseButtonState createState() => _PlayPauseButtonState();
}

class _PlayPauseButtonState extends State<PlayPauseButton> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
