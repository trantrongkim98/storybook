import 'package:chat_message/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class KAudio extends StatefulWidget {
  final EdgeInsets padding;
  final Color backgroundColor;
  final PlayPauseButton playPauseButton;
  const KAudio({
    Key key,
    this.padding,
    this.backgroundColor,
    this.playPauseButton,
  }) : super(key: key);
  @override
  _KAudioState createState() => _KAudioState();
}

class _KAudioState extends BaseState<KAudio> {
  final AudioPlayer _audioPlayer = AudioPlayer(
    mode: PlayerMode.LOW_LATENCY,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: widget.padding,
      color: widget.backgroundColor,
      width: mediaData.size.width * 0.6,
      child: _content(),
    );
  }

  Widget _content() {
    return Row(
      children: [
        _buildTime(),
        Spacer(),
        _buildButtonPlayAndPause(),
      ],
    );
  }

  Widget _buildButtonPlayAndPause() {
    return Container();
  }

  Widget _buildTime() {
    return Container();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
