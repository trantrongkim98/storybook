import 'package:flutter/material.dart';
import 'package:chat_message/src/ui/base/base_state.dart';

extension KMatchString on String {
  List<String> matchString(String pattern) {
    if (pattern.isEmpty) return [this];

    List<String> result = <String>[];
    int count = 0;
    final split = this.split(pattern);
    if (split.length == 1) return [this];
    split.forEach((v) {
      if (v.isEmpty) {
        count += pattern.length;
        if (count <= this.length) {
          result.add(pattern);
        } else {
          count -= pattern.length;
        }
      } else if (result.isEmpty && v.isNotEmpty) {
        result = [v];
        count += v.length;
      } else {
        int indexOfV = this.indexOf(v, count);
        int countAdd = (indexOfV - count) ~/ pattern.length;
        var listAdd = List.generate(countAdd, (index) => pattern);
        result.addAll(listAdd);
        count += pattern.length * countAdd;
        result.add(v);
        count += v.length;
      }
    });
    if (count < this.length) {
      int countAdd = (this.length - count) ~/ pattern.length;
      var listAdd = List.generate(countAdd, (index) => pattern);
      result.addAll(listAdd);
    }

    return result;
  }
}

class KChatItemText extends StatefulWidget {
  /// the [text]
  final String? text;

  /// the [maxSize] is max percent of width
  final double maxSize;

  /// the [style] use for all text non-match
  final TextStyle? style;

  /// the [matchText]
  final String matchText;

  /// the [margin] is empty space to surround the [decoration] and [child].
  final EdgeInsets? margin;

  ///the [padding] is empty space to inscribe inside the [decoration]
  final EdgeInsets? padding;

  /// the [backgroundColor] to paint behind the area in [KChatItemText]
  final Color? backgroundColor;

  /// the [shadows] to paint shadow outside the [KChatItemText]
  final List<BoxShadow>? shadows;

  /// the corners of this box are rounded by this [BorderRadius].
  final BorderRadius? borderRadius;

  /// the [backgroundColorMatchText] is background color when a text matches
  final Color? backgroundColorMatchText;

  const KChatItemText(
    this.text, {
    Key? key,
    this.style,
    this.margin,
    this.shadows,
    this.padding,
    this.borderRadius,
    this.maxSize = 0.6,
    this.matchText = "",
    this.backgroundColor,
    this.backgroundColorMatchText,
  }) : super(key: key);

  @override
  _KChatItemTextState createState() => _KChatItemTextState();
}

class _KChatItemTextState extends BaseState<KChatItemText> {
  List<String> _textMatch = [];
  @override
  void initState() {
    super.initState();
    _textMatch = widget.text!.matchString(widget.matchText);
  }

  @override
  void didUpdateWidget(covariant KChatItemText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.matchText != oldWidget.matchText) {
      setState(() => _textMatch = widget.text!.matchString(widget.matchText));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      padding: widget.padding,
      constraints: BoxConstraints(
        maxWidth: widget.maxSize * mediaData.size.width,
      ),
      decoration: BoxDecoration(
        boxShadow: widget.shadows,
        color: widget.backgroundColor,
        borderRadius: widget.borderRadius,
      ),
      child: RichText(
        text: TextSpan(
          children: _buildListTextSpan(),
        ),
      ),
    );
  }

  List<TextSpan> _buildListTextSpan() {
    return _textMatch.map((e) => _buildTextSpan(e)).toList();
  }

  TextSpan _buildTextSpan(String text) {
    if (text != widget.matchText) {
      return TextSpan(text: text, style: widget.style);
    }

    return TextSpan(
      text: text,
      style: widget.style!.copyWith(
        backgroundColor: widget.backgroundColorMatchText,
      ),
    );
  }
}
