import 'package:flutter/material.dart';
import 'package:youtube_api/home/home_repository.dart';
import 'package:youtube_api/shared/custom_dio/custom_dio.dart';
import 'package:youtube_api/shared/models/video_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPage extends StatefulWidget {
  final VideoModel video;
  VideoPage({Key key, this.video}) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  YoutubePlayerController _controller;

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: widget.video.id,
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
        title: Text(widget.video.title),
        actions: <Widget>[
          FutureBuilder<String>(
            future: HomeRepository(CustomDio())
                .getImage(idChannel: widget.video.idChannel),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(snapshot.data),
                    ),
                  ),
                );
              } else {
                return Container(
                  width: 0,
                  height: 0,
                );
              }
            },
          ),
        ],
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
