import 'package:chat_message/src/model/chat/message.dart';
import 'package:flutter/material.dart';
import 'package:chat_message/chat_message.dart';
import 'package:chat_message/src/ui/base/base_state.dart';
import 'package:chat_message/src/ui/widgets/zero_widget.dart';
import 'package:chat_message/src/ui/base/chat/base_chat_footer.dart';
import 'package:chat_message/src/ui/chat/chat_footer/chat_footer_import.dart';

enum KEnumFooterItem {
  MIC,
  PLUS,
  EMOJI,
  STICKERGIF,
}

class ChatFooter extends BaseChatFooter {
  final Widget mic;
  final double width;
  final String iconMic;
  final Widget sticker;
  final String hintText;
  final TextStyle style;
  final String iconSend;
  final String iconPlus;
  final String iconEmoji;
  final EdgeInsets margin;
  final String iconSticker;
  final EdgeInsets padding;
  final TextInput textInput;
  final Function(String) onTextChanged;
  final Function(KMessage) onMessageChanged;
  final Function(KEnumFooterItem) onItemChanged;

  const ChatFooter({
    Key key,
    this.mic,
    this.style,
    this.width,
    this.margin,
    this.sticker,
    this.iconMic,
    this.padding,
    this.hintText,
    this.iconSend,
    this.iconPlus,
    this.iconEmoji,
    this.textInput,
    this.iconSticker,
    this.onTextChanged,
    this.onItemChanged,
    this.onMessageChanged,
  }) : super(
          key: key,
          onTextChanged: onTextChanged,
          onMessageChanged: onMessageChanged,
        );

  @override
  _ChatFooterState createState() => _ChatFooterState();
}

class _ChatFooterState extends BaseState<ChatFooter> {
  double height = 60;
  double _heightPaddingTopBottom = 16;
  final FocusNode _focusNode = FocusNode();
  final _kTextInput = GlobalKey<TextInputState>(debugLabel: "asdfsda");

  @override
  void initState() {
    super.initState();
    if (widget.margin != null) {
      _heightPaddingTopBottom = widget.margin.bottom;
    }
    height += _heightPaddingTopBottom;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        margin: widget.margin,
        color: AppColor.white,
        width: widget.width ?? mediaData.size.width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: 0,
              bottom: _heightPaddingTopBottom / 2,
              child: _buildLayerAction(),
            ),
            Positioned(
              left: 65,
              right: 113,
              bottom: _heightPaddingTopBottom / 2,
              child: _buildTextInput(),
            ),
          ],
        ));
  }

  Widget _buildTextInput() {
    return GestureDetector(
      child: TextInput(
        minLines: 1,
        maxLines: 5,
        cursorWidth: 1,
        key: _kTextInput,
        focusNode: _focusNode,
        hintText: widget.hintText,
        iconEmoji: widget.iconEmoji,
        iconCirclePlus: widget.iconPlus,
        padding: EdgeInsets.symmetric(horizontal: 10.65),
        onTextChanged: (text) async {
          widget.onTextChanged(text);
          await Future.delayed(Duration(milliseconds: 50));
          setState(() => height =
              _kTextInput.currentContext.size.height + _heightPaddingTopBottom);
        },
      ),
    );
  }

  Widget _buildLayerAction() {
    return Container(
      width: mediaData.size.width,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildIconSticker(),
          Spacer(),
          _buildIconMicro(),
          _buildIconLikeAndSend(),
        ],
      ),
    );
  }

  Widget _buildIconSticker() {
    if (widget.iconSticker == null || widget.iconSticker.isEmpty) {
      return ZeroWidget();
    }

    return Container(
      width: 65,
      child: Image(
        image: AssetImage(
          widget.iconSticker,
        ),
        width: 26,
        height: 26,
      ),
    );
  }

  Widget _buildIconMicro() {
    if (widget.iconMic == null || widget.iconMic.isEmpty) {
      return ZeroWidget();
    }

    return Container(
      width: 51,
      alignment: Alignment.bottomCenter,
      child: Image(
        image: AssetImage(
          widget.iconMic,
        ),
      ),
    );
  }

  Widget _buildIconLikeAndSend() {
    if (widget.iconSend == null || widget.iconSend.isEmpty) {
      return ZeroWidget();
    }
    return GestureDetector(
      onTap: () {
        final message = KMessage.text(
          text: _kTextInput.currentState.text,
        );
        if (message.text.isEmpty) return;
        widget.onMessageChanged(message);
        _kTextInput.currentState.resetTextField();
      },
      child: Container(
        width: 51,
        child: Image(
          image: AssetImage(
            widget.iconSend,
          ),
        ),
      ),
    );
  }
}
