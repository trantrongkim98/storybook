import 'package:flutter/material.dart';
import 'package:chat_message/chat_message.dart';
import 'package:chat_message/src/ui/base/base_state.dart';
import 'package:chat_message/src/ui/widgets/zero_widget.dart';
import 'package:chat_message/src/ui/base/chat/base_chat_header.dart';

class KChatHeader extends BaseChatHeader {
  final Widget avatar;
  final String iconBack;
  final bool enableBack;
  final String username;
  final bool enablePhone;
  final String iconPhone;
  final Function onTapBack;
  final EdgeInsets padding;
  final Function onTapPhone;
  final bool enableUsername;
  final String iconVideoCall;
  final bool enableVideoCall;
  final Color backgroundColor;
  final Function onTapUsername;
  final Function onTapVideoCall;

  KChatHeader({
    this.avatar,
    this.padding,
    this.username,
    this.iconBack,
    this.iconPhone,
    this.onTapBack,
    this.onTapPhone,
    this.iconVideoCall,
    this.onTapUsername,
    this.onTapVideoCall,
    this.enableBack = true,
    this.enablePhone = true,
    this.enableUsername = true,
    this.enableVideoCall = true,
    this.backgroundColor = AppColor.transparent,
  });

  @override
  _KChatHeader createState() => _KChatHeader();
}

class _KChatHeader extends BaseState<KChatHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52 + mediaData.padding.top,
      padding: widget.padding,
      width: mediaData.size.width,
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        boxShadow: [
          BoxShadow(
            blurRadius: 16,
            offset: Offset(0, 8),
            color: Colors.blueGrey[50],
          ),
        ],
      ),
      child: Row(
        children: [
          _buildIconBack(),
          Expanded(child: _buildAvatar()),
          _buildIconPhone(),
          _buildIconVideoCall()
        ],
      ),
    );
  }

  Widget _buildIconBack() {
    if (!widget.enableBack ||
        widget.iconBack == null ||
        widget.iconBack.isEmpty) return ZeroWidget();
    return Container(
      width: 32,
      height: 32,
      child: Center(
        child: Image(
          image: AssetImage(widget.iconBack),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    if (!widget.enableUsername || widget.avatar == null) return ZeroWidget();
    return widget.avatar;
  }

  Widget _buildIconPhone() {
    if (!widget.enablePhone ||
        widget.iconPhone == null ||
        widget.iconPhone.isEmpty) return ZeroWidget();
    return Container(
      width: 32,
      height: 32,
      child: Center(
        child: Image(
          image: AssetImage(widget.iconPhone),
        ),
      ),
    );
  }

  Widget _buildIconVideoCall() {
    if (!widget.enableVideoCall ||
        widget.iconVideoCall == null ||
        widget.iconVideoCall.isEmpty) return ZeroWidget();

    return Container(
      width: 32,
      height: 32,
      margin: EdgeInsets.only(left: 20),
      child: Center(
        child: Image(
          image: AssetImage(widget.iconVideoCall),
        ),
      ),
    );
  }
}
