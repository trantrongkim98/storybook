import 'package:flutter/material.dart';
import 'package:chat_message/chat_message.dart';
import 'package:chat_message/src/ui/widgets/zero_widget.dart';
import 'package:chat_message/src/ui/chat/chat_header/widgets/chat_header_icon.dart';

class KChatHeaderConvertlead extends BaseChatHeader {
  final Widget avatar;
  final KChatHeaderIcon voiceCall;
  final KChatHeaderIcon videoCall;
  final KChatHeaderIcon buttonBack;
  final KChatHeaderIcon buttonMore;

  KChatHeaderConvertlead({
    this.avatar,
    this.voiceCall,
    this.videoCall,
    this.buttonBack,
    this.buttonMore,
  });
  @override
  _KChatHeaderConvertleadState createState() => _KChatHeaderConvertleadState();
}

class _KChatHeaderConvertleadState extends BaseState<KChatHeaderConvertlead> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIconBack(),
          _buildAction(),
        ],
      ),
    );
  }

  _buildAction() {
    return Row(
      children: [
        Expanded(child: _buildAvatar()),
        _buildIconVoiceCall(),
        _buildIconVideoCall(),
        _buildIconMore(),
      ],
    );
  }

  Widget _buildIconBack() {
    if (widget.buttonBack == null) {
      return ZeroWidget();
    }
    return widget.buttonBack;
  }

  Widget _buildAvatar() {
    if (widget.avatar == null) {
      return ZeroWidget();
    }
    return widget.avatar;
  }

  Widget _buildIconMore() {
    if (widget.buttonMore == null) {
      return ZeroWidget();
    }

    return widget.buttonMore;
  }

  Widget _buildIconVoiceCall() {
    if (widget.voiceCall == null) {
      return ZeroWidget();
    }
    return widget.voiceCall;
  }

  Widget _buildIconVideoCall() {
    if (widget.videoCall == null) {
      return ZeroWidget();
    }

    return widget.videoCall;
  }
}
