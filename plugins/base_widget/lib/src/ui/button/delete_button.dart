import 'package:base_widget/src/ui/button/button_state.dart';
import 'package:flutter/material.dart';

class DeleteButton extends StatefulWidget {
  final IconData icon;
  final String text;
  final double width;
  final double height;
  final TextStyle style;
  final ButtonState state;
  final Color backgroundColor;
  final List<BoxShadow> shadows;
  final BorderRadius borderRadius;

  const DeleteButton({
    Key key,
    this.icon,
    this.text,
    this.width,
    this.style,
    this.state,
    this.height,
    this.shadows,
    this.borderRadius,
    this.backgroundColor,
  })  : assert(text != null),
        assert(width >= 0),
        assert(height >= 0),
        super(key: key);
  @override
  _DeleteButtonState createState() => _DeleteButtonState();
}

class _DeleteButtonState extends State<DeleteButton>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _anim;
  Animation<double> _animSize;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300))
          ..addListener(() {
            setState(() {});
          });
    _anim = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
    _animSize = Tween<double>(begin: 1, end: 1.5)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    super.initState();
  }

  @override
  void didUpdateWidget(covariant DeleteButton oldWidget) {
    if (oldWidget.state != widget.state || _controller.isCompleted) {
      switch (widget.state) {
        case ButtonState.IDLE:
          _controller.reverse();
          break;
        case ButtonState.DOING:
          _controller.forward();
          break;
        case ButtonState.DONE:
          break;
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_controller.isDismissed) {
          _controller.forward();
        }
      },
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: widget.borderRadius,
          color: widget.backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[400],
              blurRadius: 24 * _anim.value,
              offset: Offset(0, 2 * _anim.value),
            )
          ],
        ),
        child: Row(
          children: [
            _buildIcon(),
            _buildText(),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      width: widget.height,
      height: widget.height,
      transform: Matrix4.translationValues(
          _anim.value * ((widget.width - widget.height) / 2), 0, 0),
      child: Transform.scale(
        scale: _animSize.value,
        child: Icon(
          widget.icon,
          size: widget.height * 0.45,
        ),
      ),
    );
  }

  Widget _buildText() {
    return Opacity(
      opacity: 1.0 - (_anim.value <= 0.5 ? _anim.value * 2 : 1),
      child: Container(
        transform: Matrix4.translationValues(_anim.value * widget.width, 0, 0),
        child: Text(
          widget.text,
          style: widget.style,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
