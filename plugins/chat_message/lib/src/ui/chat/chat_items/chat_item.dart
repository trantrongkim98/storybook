import 'package:flutter/material.dart';
import 'package:chat_message/chat_message.dart';
import 'package:chat_message/src/ui/base/base_state.dart';
import 'package:chat_message/src/ui/widgets/zero_widget.dart';

enum ItemStatus {
  SEEN,
  READED,
  UNREAD,
  FAILED,
  AVATAR,
}

extension _GetIcon on ItemStatus {
  String get icon {
    switch (this) {
      case ItemStatus.SEEN:
        return "seen";
        break;
      case ItemStatus.FAILED:
        return "";
        break;
      case ItemStatus.AVATAR:
        return "avatar";
        break;
      case ItemStatus.READED:
        return "";
        break;
      case ItemStatus.UNREAD:
        return "";
        break;
      default:
        return "";
        break;
    }
  }
}

class KChatItem extends StatefulWidget {
  final bool isTap;
  final Widget avatar;
  final Widget topView;
  final Function onTap;
  final Widget bottomView;
  final Widget itemBuilder;
  final double heightTopView;
  final ItemStatus itemStatus;
  final EChatLocation location;
  final double heightBottomView;

  const KChatItem({
    Key key,
    this.onTap,
    this.avatar,
    this.topView,
    this.bottomView,
    this.isTap = false,
    this.heightTopView,
    this.heightBottomView,
    @required this.itemStatus,
    @required this.itemBuilder,
    this.location = EChatLocation.RIGHT,
  })  : assert(itemStatus != null),
        assert(itemBuilder != null),
        super(key: key);
  @override
  KChatItemState createState() => KChatItemState();
}

class KChatItemState extends BaseState<KChatItem>
    with TickerProviderStateMixin {
  bool _isOpenInfo;
  @override
  void initState() {
    super.initState();
    _isOpenInfo = widget.isTap;
  }

  @override
  void didUpdateWidget(covariant KChatItem oldWidget) {
    if (widget.isTap && !oldWidget.isTap) {
      _isOpenInfo = true;
    } else if (widget.isTap && oldWidget.isTap) {
      _isOpenInfo = false;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          _buildTopView(),
          Row(
            mainAxisAlignment: getLocation(),
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              widget.location == EChatLocation.RIGHT
                  ? _buildContent()
                  : _buildStatus(),
              widget.location == EChatLocation.RIGHT
                  ? _buildStatus()
                  : _buildContent(),
            ],
          ),
          _buildBottomView(),
        ],
      ),
    );
  }

  MainAxisAlignment getLocation() {
    switch (widget.location) {
      case EChatLocation.LEFT:
        return MainAxisAlignment.start;
        break;
      case EChatLocation.RIGHT:
        return MainAxisAlignment.end;
        break;
      case EChatLocation.CENTER:
        return MainAxisAlignment.center;
        break;
    }
    return MainAxisAlignment.end;
  }

  Widget _buildContent() {
    if (widget.itemBuilder == null) {
      return Container();
    }
    return GestureDetector(
      onLongPressStart: _onPressStart,
      onLongPressEnd: _onPressEnd,
      onTap: widget.onTap,
      child: Container(
        child: widget.itemBuilder,
        color: AppColor.transparent,
      ),
    );
  }

  Widget _buildStatus() {
    if (widget.itemStatus.icon.isEmpty ||
        widget.itemStatus == ItemStatus.SEEN) {
      return ZeroWidget(
        width: 20,
      );
    }
    if (widget.itemStatus == ItemStatus.AVATAR) {
      return widget.avatar ??
          ZeroWidget(
            width: 20,
          );
    }

    return Container(
      child: Image(
        image: AssetImage(widget.itemStatus.icon),
      ),
    );
  }

  Widget _buildTopView() {
    if (widget.topView == null) {
      return ZeroWidget();
    }

    return AnimatedContainer(
      child: widget.topView,
      width: mediaData.size.width,
      duration: Duration(milliseconds: 300),
      height: widget.isTap && _isOpenInfo ? widget.heightTopView : 0,
    );
  }

  Widget _buildBottomView() {
    if (widget.bottomView == null) {
      return ZeroWidget();
    }

    return AnimatedContainer(
      child: widget.bottomView,
      width: mediaData.size.width,
      duration: Duration(milliseconds: 300),
      height: widget.isTap && _isOpenInfo ? widget.heightBottomView : 0,
    );
  }

  void _onPressStart(LongPressStartDetails start) {}
  void _onPressEnd(LongPressEndDetails end) {}
}
