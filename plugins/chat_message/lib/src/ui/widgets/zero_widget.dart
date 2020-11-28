import 'package:flutter/material.dart';
import 'package:chat_message/chat_message.dart';

class ZeroWidget extends StatelessWidget {
  final double width;

  const ZeroWidget({Key key, this.width}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      width: this.width ?? 0,
      color: AppColor.transparent,
    );
  }
}
