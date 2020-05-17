import 'package:flutter/material.dart';
import 'package:youtube_api/shared/custom_dio/custom_dio.dart';
import 'package:youtube_api/shared/models/video_model.dart';
import 'package:youtube_api/shared/utils/transform_util.dart';
import 'package:youtube_api/video/video_page.dart';

import '../home_repository.dart';

class TileVideo extends StatelessWidget {
  final VideoModel snapshot;
  const TileVideo({Key key, @required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VideoPage(
                      video: snapshot,
                    )));
      },
      child: Container(
        child: Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                width: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(snapshot.url), fit: BoxFit.cover)),
              ),
            ),
            ListTile(
              isThreeLine: true,
              title: Text(
                snapshot.title,
                maxLines: 2,
              ),
              leading: FutureBuilder<String>(
                future: HomeRepository(CustomDio())
                    .getImage(idChannel: snapshot.idChannel),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(snapshot.data),
                    );
                  } else {
                    return Container(
                      width: 0,
                      height: 0,
                    );
                  }
                },
              ),
              subtitle: FutureBuilder<String>(
                  future: HomeRepository(CustomDio())
                      .getStatistics(idVideo: snapshot.id),
                  builder: (context, future) {
                    if (future.hasData) {
                      return Text(
                        "${snapshot.channelTitle} ● ${TransformUtil.views(future.data)} há ${TransformUtil.dateParse(snapshot.publishedAt)}",
                        overflow: TextOverflow.ellipsis,
                      );
                    } else {
                      return Text("...");
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
