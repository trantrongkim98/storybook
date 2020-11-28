import 'package:chat_message/src/utils/const/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:chat_message/chat_message.dart';
import 'package:chat_message/src/ui/base/base_state.dart';
import 'package:chat_message/src/ui/widgets/zero_widget.dart';
import 'package:chat_message/src/model/base/base_chat_item.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

enum FloatingActionLocation { TOPLEFT, TOPRIGHT, BOTTOMLEFT, BOTTOMRIGHT }

class KChatContent extends StatefulWidget {
  final Widget typing;
  final Widget refreshItem;
  final EdgeInsets padding;
  final List<BaseItemChat> items;
  final Widget buttonMoveToBegin;
  final Future Function() onRefresh;
  final AnimatedListItemBuilder builder;
  final FloatingActionLocation floatingActionLocation;

  const KChatContent({
    Key key,
    this.typing,
    this.padding,
    this.onRefresh,
    this.refreshItem,
    @required this.items,
    this.buttonMoveToBegin,
    @required this.builder,
    this.floatingActionLocation = FloatingActionLocation.BOTTOMRIGHT,
  }) : super(key: key);

  /// method [of(context)] use context of children in builder of widget [ChatContent]
  /// and never use without context of children ChatContent
  static KChatContentState of(BuildContext context) {
    final result = context.findAncestorStateOfType<KChatContentState>();
    if (result != null) {
      return result;
    }

    throw ErrorSummary("subtree wasn't contain ChatContentState");
  }

  @override
  KChatContentState createState() => KChatContentState();
}

class KChatContentState extends BaseState<KChatContent> {
  double _hTyping = 0;
  bool _lockCallApi = false;
  bool _isShowRefresh = false;
  double _offsetTopRefresh = 0;
  bool _isShowActionButton = false;
  ScrollController _controller = ScrollController(initialScrollOffset: 0);
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  final KeyboardVisibilityController _keyboardVisibilityController =
      KeyboardVisibilityController();
  @override
  void initState() {
    super.initState();
    _controller.addListener(_listenerList);
    if (!kIsWeb) {
      _keyboardVisibilityController.onChange.listen((event) {
        if (event) {
          Future.delayed(Duration(milliseconds: 50), () {
            if (_controller.offset != 0) {
              scrollToOffset(0, 200);
            }
          });
        }
      });
    }
  }

  _listenerList() {
    // offset large than 10% screen height
    bool offsetLargeHeight = _controller.offset > mediaData.size.height * 0.1;
    // offset low than 10% of screen height
    bool offsetLowHeight = _controller.offset < mediaData.size.height * 0.1;

    if (!_isShowActionButton && offsetLargeHeight) {
      setState(() => _isShowActionButton = true);
    } else if (_isShowActionButton && offsetLowHeight) {
      setState(() => _isShowActionButton = false);
    }

    // scroll large than maxExtent
    bool scrollExt = _controller.offset > _controller.position.maxScrollExtent;

    if (!_isShowRefresh && scrollExt && widget.refreshItem != null) {
      setState(() => _isShowRefresh = true);
    }

    if (_isShowRefresh && widget.refreshItem != null) {
      _processRefreshItem();
    }
  }

  _processRefreshItem() {
    double offset = _controller.position.maxScrollExtent - _controller.offset;
    if (offset < 0) {
      // scroll loading to 25% screen height
      offset = offset.abs();
      if (offset < mediaData.size.height / 2) {
        setState(() => _offsetTopRefresh = offset / 2);
      }
    } else if (offset == 0) {
      // handler call api
      if (!_lockCallApi) {
        if (widget.onRefresh == null) {
          Future.delayed(
              Duration(milliseconds: 500), () => _stateTransitionRefresh(null));
        } else {
          _lockCallApi = true;
          widget.onRefresh().then(_stateTransitionRefresh);
        }
      }
    } else {
      // scroll to top of screen
      if (offset < 0) {
        offset = 0;
      }
      setState(() => _offsetTopRefresh = -offset);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: _buildChat()),
        _isShowRefresh ? _buildRefresh() : Container(),
        _isShowActionButton ? _buildFloatingActionButton() : Container()
      ],
    );
  }

  Widget _buildRefresh() {
    return Positioned(
      top: _offsetTopRefresh,
      child: Container(
        child: widget.refreshItem,
        width: mediaData.size.width,
      ),
    );
  }

  Widget _buildFloatingActionButton() {
    if (widget.buttonMoveToBegin == null) {
      return Container();
    }
    switch (widget.floatingActionLocation) {
      case FloatingActionLocation.TOPLEFT:
        return _buildFloatActionButtonTopLeft();
        break;
      case FloatingActionLocation.TOPRIGHT:
        return _buildFloatActionButtonTopRight();
        break;
      case FloatingActionLocation.BOTTOMLEFT:
        return _buildFloatActionButtonBottomLeft();
        break;
      case FloatingActionLocation.BOTTOMRIGHT:
        return _buildFloatActionButtonBottomRight();
        break;
      default:
        return ZeroWidget();
    }
  }

  Widget _buildGestureFloatingButton() {
    return GestureDetector(
      onTap: () => scrollToOffset(0, 300),
      child: widget.buttonMoveToBegin,
    );
  }

  Widget _buildFloatActionButtonTopLeft() {
    return Positioned(top: 20, left: 20, child: _buildGestureFloatingButton());
  }

  Widget _buildFloatActionButtonTopRight() {
    return Positioned(top: 20, right: 20, child: _buildGestureFloatingButton());
  }

  Widget _buildFloatActionButtonBottomLeft() {
    return Positioned(
        bottom: 20, left: 20, child: _buildGestureFloatingButton());
  }

  Widget _buildFloatActionButtonBottomRight() {
    return Positioned(
        bottom: 20, right: 20, child: _buildGestureFloatingButton());
  }

  Widget _buildChat() {
    return Container(
      constraints: BoxConstraints(minHeight: 100),
      child: ListView.builder(
        key: listKey,
        reverse: true,
        padding: widget.padding,
        controller: _controller,
        physics: BouncingScrollPhysics(),
        itemCount: widget.items.length + 2,
        itemBuilder: (context, index) {
          if (index == widget.items.length + 1) {
            if (!_isShowRefresh || widget.refreshItem == null) {
              return ZeroWidget();
            }
            return Opacity(opacity: 0, child: widget.refreshItem);
          }

          if (index == 0) {
            if (widget.typing == null) {
              return ZeroWidget();
            }
            return _buildTypeStatus();
          }
          return widget.builder(context, index - 1, null);
        },
      ),
    );
  }

  Widget _buildTypeStatus() {
    return AnimatedContainer(
        height: _hTyping,
        duration: Duration(milliseconds: 300),
        curve: Curves.linear,
        color: AppColor.transparent,
        padding: EdgeInsets.only(left: 20, bottom: 8),
        child: widget.typing ?? ZeroWidget());
  }

  void _stateTransitionRefresh(dynamic d) {
    _lockCallApi = false;
    setState(() => _isShowRefresh = !_isShowRefresh);
  }

  @override
  void didUpdateWidget(covariant KChatContent oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.removeListener(_listenerList);
    super.dispose();
  }

  // public method

  void showDetailItemWhenTap(int index, BaseItemChat Function() updateItem) {
    var indexItem = widget.items
        .indexWhere((element) => element.isTap)
        .clamp(0, widget.items.length);

    setState(() {
      widget.items[indexItem].isTap =
          indexItem == index ? widget.items[indexItem].isTap : false;
      widget.items[index] = updateItem();
    });
  }

  void scrollToOffset(double offset, int duration) {
    _controller
        .animateTo(offset,
            duration: Duration(milliseconds: duration), curve: Curves.linear)
        .then((_) => setState(() => _isShowActionButton = false));
  }

  void hideTyping({double height = 0}) => setState(() => _hTyping = height);

  void showTyping({double height = 36}) => setState(() => _hTyping = height);

  bool get isShowTyping => _hTyping != 0;
}
