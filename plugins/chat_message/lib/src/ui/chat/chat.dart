import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:chat_message/chat_message.dart';
import 'package:chat_message/src/ui/widgets/zero_widget.dart';

class KChatMessage extends StatefulWidget {
  static const String router = "chat_control";
  final Widget? typing;
  final String? matchText;
  final bool isShowTyping;
  final EdgeInsets? padding;
  final Widget? refreshItem;
  final BorderRadius? chatRadius;
  final Widget? buttonMoveToBegin;
  final List<BaseItemChat> items;
  final Color? chatBackgroundColor;
  final BaseChatHeader? chatHeader;
  final BaseChatFooter? chatFooter;
  final Future Function()? onRefresh;
  final IndexedWidgetBuilder? builder;
  final FloatingActionLocation? floatingActionLocation;

  const KChatMessage({
    Key? key,
    this.items = const [],
    this.typing,
    this.padding,
    this.matchText,
    this.onRefresh,
    this.chatHeader,
    this.chatFooter,
    this.refreshItem,
    this.buttonMoveToBegin,
    this.builder,
    this.isShowTyping = false,
    this.floatingActionLocation,
    this.chatRadius = BorderRadius.zero,
    this.chatBackgroundColor = AppColor.transparent,
  }) : super(key: key);

  static _KChatMessageState of(BuildContext context) {
    final result = context.findAncestorStateOfType<_KChatMessageState>();
    if (result != null) {
      return result;
    }
    throw ErrorSummary("subtree wasn't contain _KChatMessageState");
  }

  @override
  _KChatMessageState createState() => _KChatMessageState();
}

class _KChatMessageState extends BaseState<KChatMessage>
    with WidgetsBindingObserver {
  final _kChatContentState = GlobalKey<KChatContentState>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
  }

  @override
  void didUpdateWidget(covariant KChatMessage oldWidget) {
    if (widget.isShowTyping != oldWidget.isShowTyping) {
      if (widget.isShowTyping ||
          !_kChatContentState.currentState!.isShowTyping) {
        _kChatContentState.currentState!.showTyping();
      } else {
        _kChatContentState.currentState!.hideTyping();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.5,
          color: Colors.black,
        ),
      ),
      child: _buildChatAndBottom(),
    );
  }

  Widget _buildChatAndBottom() {
    return Column(
      children: [
        _buildHeader(),
        Expanded(child: _buildChat()),
        _buildInput(),
      ],
    );
  }

  Widget _buildHeader() {
    if (widget.chatHeader == null) {
      return ZeroWidget();
    }
    return widget.chatHeader!;
  }

  Widget _buildChat() {
    return ClipRRect(
      borderRadius: widget.chatRadius,
      child: Container(
        color: widget.chatBackgroundColor,
        child: KChatContent(
          items: widget.items,
          typing: widget.typing,
          key: _kChatContentState,
          padding: widget.padding,
          builder: widget.builder,
          onRefresh: widget.onRefresh,
          refreshItem: widget.refreshItem,
          buttonMoveToBegin: widget.buttonMoveToBegin,
          floatingActionLocation: widget.floatingActionLocation,
        ),
      ),
    );
  }

  Widget _buildInput() {
    if (widget.chatFooter == null) {
      return ZeroWidget();
    }

    return widget.chatFooter!;
  }
}
