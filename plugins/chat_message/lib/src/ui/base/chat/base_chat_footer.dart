import 'package:chat_message/src/model/chat/message.dart';
import 'package:flutter/material.dart';

typedef OnTextChangedCallback = void Function(String);
typedef OnMessageChangedCallback = void Function(KMessage);

abstract class BaseChatFooter extends StatefulWidget {
  final OnTextChangedCallback? onTextChanged;
  final OnMessageChangedCallback? onMessageChanged;

  const BaseChatFooter({
    Key? key,
    this.onTextChanged,
    this.onMessageChanged,
  }) : super(key: key);
}
