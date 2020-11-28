import 'package:flutter/material.dart';

class KCircleAvatarStatus extends StatelessWidget {
  final String url;

  const KCircleAvatarStatus({
    Key key,
    this.url =
        "https://image.shutterstock.com/image-photo/white-transparent-leaf-on-mirror-600w-1029171697.jpg",
  })  : assert(url != ""),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 20,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image(
          image: NetworkImage(this.url),
        ),
      ),
    );
  }
}
