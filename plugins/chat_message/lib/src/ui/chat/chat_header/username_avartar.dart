import 'package:chat_message/src/ui/widgets/zero_widget.dart';
import 'package:flutter/material.dart';

class KUsernameAvatar extends StatelessWidget {
  final String url;
  final String title;
  final String status;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final TextStyle statusStyle;
  final TextStyle usernameStyle;

  const KUsernameAvatar({
    Key key,
    this.margin,
    this.padding,
    this.title = "",
    this.status = "",
    this.statusStyle,
    this.usernameStyle,
    @required this.url,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: this.margin,
      padding: this.padding,
      child: Row(
        children: [
          _buildAvatar(),
          _buildTitle(),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return Container(
        child: ClipRRect(
      borderRadius: BorderRadius.circular(21),
      child: Image.network(
        this.url,
        width: 42,
        height: 42,
      ),
    ));
  }

  Widget _buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 8),
          child: Text(
            this.title,
            style: this.usernameStyle,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        this.status.isNotEmpty
            ? Container(
                margin: EdgeInsets.only(left: 8),
                child: Text(
                  this.status,
                  style: this.statusStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            : ZeroWidget(),
      ],
    );
  }
}
