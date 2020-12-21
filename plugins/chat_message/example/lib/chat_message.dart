import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:chat_message/chat_message.dart';
import 'package:chat_message_example/utils/fonts/font.dart';
import 'package:chat_message_example/utils/assets/assets.dart';

class ChatMessageExample extends StatefulWidget {
  static const String router = "chat_control";
  const ChatMessageExample({Key key}) : super(key: key);

  @override
  _ChatMessageExampleState createState() => _ChatMessageExampleState();
}

class _ChatMessageExampleState extends BaseState<ChatMessageExample>
    with WidgetsBindingObserver {
  String _matchText = "";
  List<BaseItemChat> items;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    items = getDataTest(50);
  }

  List<BaseItemChat> getDataTest(int count) {
    return List.generate(
      count,
      (index) => BaseItemChat(
        location: EChatLocation.values[Random().nextInt(2)],
        message: KMessage.text(
          text: getRandomString(
            Random().nextInt(300),
          ),
        ),
      ),
    );
  }

  String _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: mediaData.size.width,
      height: mediaData.size.height,
      decoration: BoxDecoration(
        color: Colors.deepPurple[600],
        border: Border.all(
          width: 0.5,
          color: Colors.black,
        ),
      ),
      child: KChatMessage(
        chatBackgroundColor: Colors.amber,
        chatRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        items: items,
        isShowTyping: true,
        typing: Container(),
        floatingActionLocation: FloatingActionLocation.BOTTOMRIGHT,
        buttonMoveToBegin: FloatingActionButton(
          onPressed: null,
          child: Center(
            child: Icon(Icons.keyboard_arrow_down),
          ),
        ),
        refreshItem: Container(
          child: KCirleIndicatorRefresh(
            color: Colors.red,
          ),
        ),
        onRefresh: () async {
          await Future.delayed(Duration(milliseconds: 300));
          setState(() => items.addAll(getDataTest(20)));
        },
        chatHeader: _chatHeaderConvertLead(),
        chatFooter: _buildFooter(),
        builder: (context, index, anim) {
          return KChatItem(
              key: ValueKey<BaseItemChat>(items[index]),
              location: items[index].location,
              heightTopView: 20,
              heightBottomView: 20,
              isTap: items[index].isTap,
              itemStatus: index == 0 ? ItemStatus.AVATAR : ItemStatus.UNREAD,
              onTap: () {
                KChatContent.of(context).showDetailItemWhenTap(index,
                    () => items[index].copyWith(isTap: !items[index].isTap));
              },
              avatar: KCircleAvatarStatus(),
              topView: Container(
                alignment: Alignment.center,
                child: Text("safasd"),
              ),
              itemBuilder: _buildItemText(index),
              bottomView: _buildBottomView());
        },
      ),
    );
  }

  Widget _buildItemText(int index) {
    // if (index % 3 == 0) {
    //   return KAudio(
    //     backgroundColor: Colors.red,
    //   );
    // }
    return KChatItemText(
      items[index].message.text,
      matchText: _matchText,
      backgroundColor: Colors.blue,
      borderRadius: BorderRadius.circular(16),
      backgroundColorMatchText: Colors.yellow,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      style: TextStyle(
        fontSize: 15,
        letterSpacing: 0.3,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        fontFamily: AppFont.futuraBT_Book,
        color: items[index].location == EChatLocation.RIGHT
            ? AppColor.white
            : items[index].location == EChatLocation.LEFT
                ? Color(0xFF121213)
                : AppColor.black,
      ),
    );
  }

  Widget _buildBottomView() {
    return Container(
      height: 20,
      color: Colors.blue,
      width: mediaData.size.width,
      alignment: Alignment.centerRight,
      margin: EdgeInsets.only(right: 20),
      child: Text("10:20 PM",
          style: TextStyle(
            fontSize: 14,
            fontFamily: AppFont.futuraBT_Heavy,
          )),
    );
  }

  Widget _buildHeader() {
    return KChatHeader(
      iconBack: AppAsset.icBack,
      iconPhone: AppAsset.icPhone,
      iconVideoCall: AppAsset.icVideoCall,
      avatar: KUsernameAvatar(
          padding: EdgeInsets.only(
            left: 12,
            right: 12,
          ),
          title: "Trong Kim Tran",
          usernameStyle: TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,
              fontFamily: AppFont.futuraBQ_Medium,
              color: Color(0xFF121213)),
          url:
              "https://png.pngtree.com/png-clipart/20190617/original/pngtree-mid-autumn-festival-hand-painted-mooncake-hello-emoticon-pack-mid-autumn-png-image_3858239.jpg"),
      padding: EdgeInsets.only(
        left: 11,
        right: 20,
      ),
    );
  }

  Widget _chatHeaderConvertLead() {
    return KChatHeaderConvertlead(
      voiceCall: KChatHeaderIcon(
        width: 40,
        icon: AppAsset.icPhone,
      ),
      videoCall: KChatHeaderIcon(
        width: 40,
        icon: AppAsset.icVideoCall,
      ),
      buttonBack: KChatHeaderIcon(
        width: 66,
        height: 57,
        icon: AppAsset.icBack,
      ),
      buttonMore: KChatHeaderIcon(
        icon: AppAsset.icBack,
        width: 40,
      ),
      avatar: KUsernameAvatar(
          status: "online",
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          title: "Trong Kim Tran",
          statusStyle: TextStyle(
            fontSize: 16,
            fontStyle: FontStyle.normal,
            fontFamily: AppFont.futuraBQ_Medium,
            color: AppColor.white.withOpacity(0.8),
          ),
          usernameStyle: TextStyle(
            fontSize: 16,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
            fontFamily: AppFont.futuraBQ_Medium,
            color: AppColor.white,
          ),
          url:
              "https://png.pngtree.com/png-clipart/20190617/original/pngtree-mid-autumn-festival-hand-painted-mooncake-hello-emoticon-pack-mid-autumn-png-image_3858239.jpg"),
    );
  }

  Widget _buildFooter() {
    return ChatFooter(
      iconSend: AppAsset.icLikeEnable,
      iconMic: AppAsset.icMicroDisable,
      iconEmoji: AppAsset.icEmojiDisable,
      iconPlus: AppAsset.icCirclePlusDisable,
      iconSticker: AppAsset.icStickerGifEnable,
      onMessageChanged: (KMessage message) {
        final msg = BaseItemChat(
          isTap: false,
          message: message,
          location: EChatLocation.RIGHT,
        );

        setState(() {
          items.insert(0, msg);
        });
      },
      onTextChanged: (text) {
        setState(() => _matchText = text);
      },
    );
  }
}
