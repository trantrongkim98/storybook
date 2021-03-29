import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KTextInput extends StatefulWidget {
  /// [hint] hint text of TextField
  final String? hint;

  /// [error] that is a Widget show error of TextField
  final Widget? error;

  /// [isLines] if it is False => single line else multiple lines
  final bool isLines;

  /// A border to draw above the background [color], [gradient], or [image].
  ///
  /// Follows the [shape] and [borderRadius].
  ///
  /// Use [Border] objects to describe borders that do not depend on the reading
  /// direction.
  ///
  /// Use [BoxBorder] objects to describe borders that should flip their left
  /// and right edges based on whether the text is being read left-to-right or
  /// right-to-left.
  final Border? border;

  /// A widget to show UI and action previous TextField
  final Widget? prefix;

  /// A boolean to show or hide password
  final bool password;

  /// A widget to show UI and action behind TextField
  final Widget? suffix;

  /// A boolean to show underline under TextField
  final bool underline;

  ///
  final TextStyle? style;
  final EdgeInsets? margin;
  final Color shadowColor;
  final EdgeInsets? padding;
  final FocusNode? focusNode;
  final TextStyle? hintStyle;
  final String passwordHint;
  final Function()? onTapPrefix;
  final Function()? onTapSuffix;
  final Color? backgroundColor;
  final BorderRadius borderRadius;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final Function(Size)? onSizeCallback;
  final Brightness keyboardAppearance;
  final TextInputAction textInputAction;
  final TextEditingController? controller;
  final List<TextInputFormatter>? formatters;
  final TextCapitalization textCapitalization;

  const KTextInput({
    Key? key,
    this.hint,
    this.style,
    this.prefix,
    this.suffix,
    this.border,
    this.underline = false,
    this.formatters,
    this.padding,
    this.hintStyle,
    this.margin,
    this.borderRadius = BorderRadius.zero,
    this.passwordHint = "*",
    this.password = false,
    this.onChanged,
    this.onSubmitted,
    this.error,
    this.focusNode,
    this.controller,
    this.onTapPrefix,
    this.onTapSuffix,
    this.onSizeCallback,
    this.isLines = false,
    this.backgroundColor,
    this.shadowColor = Colors.blue,
    this.keyboardAppearance = Brightness.light,
    this.textInputAction = TextInputAction.done,
    this.textCapitalization = TextCapitalization.none,
  }) : super(key: key);

  @override
  _KTextInputState createState() => _KTextInputState();
}

class _KTextInputState extends State<KTextInput>
    with SingleTickerProviderStateMixin, AfterLayoutMixin {
  final _key =
      GlobalKey(debugLabel: "State ${DateTime.now().toIso8601String()}");
  final _keyTF =
      GlobalKey(debugLabel: "TextField ${DateTime.now().toIso8601String()}");
  double _height = 0.0;
  FocusNode? _focusNode;
  int _lines = 1;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode?.addListener(() {
      setState(() {});
      print(_focusNode!.hasFocus);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _key,
      margin: widget.margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_content(), widget.error ?? Container()],
      ),
    );
  }

  Widget _content() {
    return Container(
      decoration: BoxDecoration(
        border: widget.border,
        borderRadius: widget.borderRadius,
        boxShadow: _focusNode!.hasFocus
            ? [
                BoxShadow(
                    color: widget.shadowColor,
                    blurRadius: 0.2,
                    spreadRadius: 0.4,
                    offset: Offset(0, 0))
              ]
            : [],
        color: widget.backgroundColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_prefix(), Expanded(child: _buildInput()), _suffix()],
      ),
    );
  }

  Widget _suffix() {
    return GestureDetector(
      onTap: widget.onTapSuffix,
      child: Container(
        color: Colors.transparent,
        child: widget.suffix ?? Container(),
      ),
    );
  }

  Widget _prefix() {
    return GestureDetector(
      onTap: widget.onTapPrefix,
      child: Container(
        color: Colors.transparent,
        child: widget.prefix ?? Container(),
      ),
    );
  }

  Widget _buildInput() {
    return Container(
      padding: widget.padding,
      child: TextField(
        key: _keyTF,
        maxLines: _lines,
        style: widget.style,
        focusNode: _focusNode,
        onChanged: widget.onChanged,
        obscureText: widget.password,
        controller: widget.controller,
        onSubmitted: widget.onSubmitted,
        inputFormatters: widget.formatters,
        obscuringCharacter: widget.passwordHint,
        textInputAction: widget.textInputAction,
        keyboardAppearance: widget.keyboardAppearance,
        textCapitalization: widget.textCapitalization,
        decoration: InputDecoration(
          hintText: widget.hint,
          border: InputBorder.none,
          hintStyle: widget.hintStyle,
        ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    final _context = _key.currentContext;
    final _ctxTF = _keyTF.currentContext;
    if (_context != null) {
      final renderBox = _context.findRenderObject() as RenderBox;
      if (widget.onSizeCallback != null) widget.onSizeCallback!(renderBox.size);
      setState(() => _height = renderBox.size.height);
    }
    if (_ctxTF != null) {
      final _renderBox = _ctxTF.findRenderObject() as RenderBox;
      print(_renderBox.size);
    }
  }

  @override
  void dispose() {
    _focusNode?.unfocus();
    _focusNode?.dispose();
    super.dispose();
  }
}
