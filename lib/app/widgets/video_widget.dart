import 'package:asas/app/theme/lightColors.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoWidget extends StatefulWidget {
  final String url;
  const VideoWidget({Key? key, required this.url}) : super(key: key);

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {

  String splitYoutubeUrl(String url){
    var urlLast = url;
    return urlLast.split("/").last.split('?').last.split('=').last;
  }

  late YoutubePlayerController youtubeController ;

  @override
  void initState() {
    youtubeController = YoutubePlayerController(
      initialVideoId: splitYoutubeUrl(widget.url),
      flags: YoutubePlayerFlags(
        isLive: false,
        autoPlay: false,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    youtubeController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
    height: 200,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: YoutubePlayer(
        controller: youtubeController,
        showVideoProgressIndicator: true,
        progressColors: ProgressBarColors(
          backgroundColor: LightColors.DIVIDER_COLOR,
          bufferedColor: LightColors.ACCENT_COLOR,
          handleColor: LightColors.PRIMARY_COLOR,
          playedColor: LightColors.PRIMARY_COLOR
        ),
      ),
    ),
  );
  }
}
