import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:youtube_api/shared/models/video_model.dart';
import 'home_bloc.dart';
import 'widgets/tile_video.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ModularState<HomePage, HomeBloc> {
  void search(String value) {
    controller.getVideos(search: value);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(size.width);
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (value) => controller.getVideos(search: value),
        ),
      ),
      body: StreamBuilder<List<VideoModel>>(
          stream: controller.videosOut,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else if (snapshot.hasData) {
              return Scrollbar(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 20),
                    itemBuilder: (context, index) => TileVideo(
                      snapshot: snapshot.data[index],
                      onTap: () {
                        Modular.to.pushNamed(
                          "/video/${snapshot.data[index].id}",
                        );
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => VideoPage(
                        //               video: snapshot.data[index],
                        //             )));
                      },
                    ),
                  ),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
