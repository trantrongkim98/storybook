import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  @protected
  MediaQueryData get mediaData => !kIsWeb
      ? MediaQuery.of(context)
      : MediaQuery.of(context).copyWith(size: Size(320, 562));
}
