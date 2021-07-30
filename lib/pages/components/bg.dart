import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class BackGround extends StatefulWidget {
  final Widget widget;
  const BackGround({Key? key, required this.widget}) : super(key: key);

  @override
  _BackGroundState createState() => _BackGroundState();
}

class _BackGroundState extends State<BackGround> {
  late VideoPlayerController _playerController;
  late VoidCallback playerListener;

  void createVideo() async {
   
      _playerController = VideoPlayerController.network('assets/ocean.m4v')
      // .network('http')
        ..initialize().then((value) => playerListener);
      _playerController.setVolume(0.0);
      _playerController.setLooping(true);
    

    await _playerController.play();
  }

  @override
  void initState() {
    super.initState();
    playerListener = () {
      setState(() {});
    };
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    createVideo();
  }

  @override
  void dispose() {
    _playerController.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    _playerController.removeListener(playerListener);
    super.deactivate();
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      child: SizedBox.expand(
        child: Stack(
          children: [
            Transform.scale(
              scale: 6.9,
              child: AspectRatio(
                aspectRatio: _playerController.value.aspectRatio,
                child: SizedBox(
                   width: _playerController.value.size.width ,
                  height: _playerController.value.size.height,
                   child: (_playerController != 0) ?
                  VideoPlayer(
                    _playerController,
                  )
                  : Container(),

                ),
              ),
            ),
            widget.widget,
          ],
        ),
      ),
    );
  }
}
