import 'package:flutter/material.dart';
import 'package:youtube_api/home/widgets/tile_video.dart';
import 'package:youtube_api/shared/custom_dio/custom_dio.dart';
import 'package:youtube_api/shared/models/video_model.dart';

import 'home_bloc.dart';
import 'home_repository.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  HomeBloc bloc;

  @override
  void initState() {
    bloc = HomeBloc(HomeRepository(CustomDio()));
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  void search(String value) {
    bloc.getVideos(search: value);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(size.width);
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (value) => bloc.getVideos(search: value),
        ),
      ),
      body: StreamBuilder<List<VideoModel>>(
          stream: bloc.videosOut,
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
