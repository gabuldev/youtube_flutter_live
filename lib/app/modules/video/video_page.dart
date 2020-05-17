import 'package:flutter/material.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPage extends StatefulWidget {
  final String idVideo;
  VideoPage({Key key, this.idVideo}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: widget.idVideo,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(widget.video.title),
        actions: <Widget>[],
      ),
      body: Column(
        children: <Widget>[
          YoutubePlayer(
            controller: _controller,
            liveUIColor: Colors.amber,
          ),
        ],
      ),
    );
  }
}
