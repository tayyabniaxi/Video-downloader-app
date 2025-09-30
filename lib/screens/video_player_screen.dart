import 'package:flutter/material.dart';
import 'package:better_player_plus/better_player_plus.dart';

class BetterPlayerScreen extends StatefulWidget {
  final String videoUrl; // direct .mp4 or HLS link
  const BetterPlayerScreen({Key? key, required this.videoUrl}) : super(key: key);

  @override
  State<BetterPlayerScreen> createState() => _BetterPlayerScreenState();
}

class _BetterPlayerScreenState extends State<BetterPlayerScreen> {
  late BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    super.initState();
    BetterPlayerConfiguration config = const BetterPlayerConfiguration(
      autoPlay: true,
      aspectRatio: 16 / 9,
      fit: BoxFit.contain,
      controlsConfiguration: BetterPlayerControlsConfiguration(
        enableFullscreen: true,
        enablePlayPause: true,
        enableSkips: true,
      ),
    );

    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      widget.videoUrl,
    );

    _betterPlayerController = BetterPlayerController(
      config,
      betterPlayerDataSource: dataSource,
    );
  }

  @override
  void dispose() {
    _betterPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(" Donwloaded Video ::::: ${widget.videoUrl}");

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("Video Player")),
      body: AspectRatio(
        aspectRatio: 16 / 9,
        child: BetterPlayer(controller: _betterPlayerController),
      ),
    );
  }
}
