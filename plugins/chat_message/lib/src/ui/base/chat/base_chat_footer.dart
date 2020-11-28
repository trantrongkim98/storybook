import 'package:chat_message/src/model/chat/message.dart';
import 'package:flutter/material.dart';

abstract class BaseChatFooter extends StatefulWidget {
  final Function(String) onTextChanged;
  final Function(KMessage) onMessageChanged;

  const BaseChatFooter({
    Key key,
    this.onTextChanged,
    this.onMessageChanged,
  }) : super(key: key);
}
