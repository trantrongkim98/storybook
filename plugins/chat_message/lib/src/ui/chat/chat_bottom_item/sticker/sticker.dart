import 'package:chat_message/chat_message.dart';
import 'package:flutter/material.dart';

class KSticker extends StatefulWidget {
  final List<dynamic> items;

  const KSticker({Key? key, this.items = const []}) : super(key: key);

  @override
  _KStickerState createState() => _KStickerState();
}

class _KStickerState extends BaseState<KSticker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(child: _buildGridKSticker()),
          _buildTabbar(),
        ],
      ),
    );
  }

  Widget _buildGridKSticker() {
    return Container(
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return Container();
        },
      ),
    );
  }

  Widget _buildTabbar() {
    return Container(
      height: 44,
      width: mediaData.size.width,
      child: SingleChildScrollView(
        child: Row(
          children: [],
        ),
      ),
    );
  }
}
