import 'package:chat_message/chat_message.dart';
import 'package:chat_message/src/ui/widgets/zero_widget.dart';
import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  final int minLines;
  final int maxLines;
  final double width;
  final TextStyle style;
  final String hintText;
  final String iconLeft;
  final String iconEmoji;
  final String iconRight;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final double cursorWidth;
  final TextStyle hintStyle;
  final FocusNode focusNode;
  final String iconCirclePlus;
  final Function(String) onTextChanged;
  const TextInput({
    Key key,
    this.style,
    this.width,
    this.margin,
    this.padding,
    this.hintText,
    this.iconLeft,
    this.iconEmoji,
    this.hintStyle,
    this.iconRight,
    this.focusNode,
    this.maxLines = 5,
    this.minLines = 1,
    this.onTextChanged,
    this.iconCirclePlus,
    this.cursorWidth = 1,
  }) : super(key: key);

  @override
  TextInputState createState() => TextInputState();
}

class TextInputState extends State<TextInput> {
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      margin: widget.margin,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Color(0xFFE9F0FB),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          width: 0.5,
          color: Colors.black,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildIconEmoji(),
          Expanded(child: _buildInput()),
          _buildIconCirclePlus(),
        ],
      ),
    );
  }

  Widget _buildIconEmoji() {
    if (widget.iconEmoji == null || widget.iconEmoji.isEmpty) {
      return ZeroWidget();
    }

    return Container(
      padding: EdgeInsets.only(left: 5, bottom: 12),
      child: Image(
        image: AssetImage(
          widget.iconEmoji,
        ),
      ),
    );
  }

  Widget _buildInput() {
    return Container(
      padding: widget.padding,
      color: AppColor.transparent,
      child: TextField(
        controller: _controller,
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        focusNode: widget.focusNode,
        onChanged: widget.onTextChanged,
        cursorWidth: widget.cursorWidth,
        cursorRadius: Radius.circular(1),
        keyboardAppearance: Brightness.light,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: widget.hintStyle,
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildIconCirclePlus() {
    if (widget.iconCirclePlus == null || widget.iconCirclePlus.isEmpty) {
      return ZeroWidget();
    }

    return Container(
      padding: EdgeInsets.only(right: 5, bottom: 12),
      child: Image(
        image: AssetImage(
          widget.iconCirclePlus,
        ),
      ),
    );
  }

  resetTextField() {
    _controller.clear();
    widget.onTextChanged("");
  }

  String get text => _controller.text;
}
