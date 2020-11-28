import 'package:chat_message/chat_message.dart';
import 'package:chat_message/src/model/chat/message.dart';

class BaseItemChat {
  bool isTap;
  KMessage message;
  EChatLocation location;

  BaseItemChat({
    this.message,
    this.location,
    this.isTap = false,
  });

  BaseItemChat copyWith({
    bool isTap,
    KMessage data,
    EChatLocation location,
  }) {
    return BaseItemChat(
      message: data ?? this.message,
      isTap: isTap ?? this.isTap,
      location: location ?? this.location,
    );
  }
}
