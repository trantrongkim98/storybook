import 'dart:typed_data';

import 'package:flutter/material.dart';

class KMessage {
  final KMessageType? type;
  final String text;
  final String sticker;
  final String urlVideo;
  final _ImageKMessage? image;

  KMessage({
    this.type,
    this.image,
    this.text = "",
    this.sticker = "",
    this.urlVideo = "",
  });

  factory KMessage.text({
    String? text,
  }) {
    return KMessage(
      text: text ?? "",
      type: KMessageType.TEXT,
    );
  }

  factory KMessage.image({
    double? width,
    double? height,
    @required Uint8List? image,
  }) {
    assert(image != null);
    return KMessage(
        type: KMessageType.IMAGE,
        image: _ImageKMessage(
          image: image!,
          width: width ?? 0,
          height: height ?? 0,
        ));
  }
}

class _ImageKMessage {
  final double? width;
  final double? height;
  final Uint8List? image;

  _ImageKMessage({
    this.image,
    this.width,
    this.height,
  });
}

enum KMessageType {
  TEXT,
  IMAGE,
  VIDEO,
  STICKER,
}
