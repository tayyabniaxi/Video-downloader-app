// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:http/http.dart' as http;
// import 'package:webview_flutter/webview_flutter.dart';
//
// class SocialMediaVideoPlayer extends StatefulWidget {
//   final String videoUrl;
//   final bool autoPlay;
//   final bool looping;
//
//   const SocialMediaVideoPlayer({
//     super.key,
//     required this.videoUrl,
//     this.autoPlay = true,
//     this.looping = true,
//   });
//
//   @override
//   State<SocialMediaVideoPlayer> createState() => _SocialMediaVideoPlayerState();
// }
//
// enum VideoPlatform { youtube, instagram, facebook, tiktok, unsupported }
//
// class _SocialMediaVideoPlayerState extends State<SocialMediaVideoPlayer> {
//   VideoPlatform _platform = VideoPlatform.unsupported;
//   YoutubePlayerController? _ytController;
//   String? _error;
//   bool _initialized = false;
//   String? _embedHtml;
//
//   @override
//   void initState() {
//     super.initState();
//     _detectAndInit();
//   }
//
//   /// Detect platform from URL
//   Future<void> _detectAndInit() async {
//     final url = widget.videoUrl;
//
//     if (url.contains('youtube.com') || url.contains('youtu.be')) {
//       _platform = VideoPlatform.youtube;
//       _initYouTube(url);
//     } else if (url.contains('instagram.com')) {
//       _platform = VideoPlatform.instagram;
//       await _fetchOEmbed("https://api.instagram.com/oembed/?url=$url");
//     } else if (url.contains('facebook.com')) {
//       _platform = VideoPlatform.facebook;
//       await _fetchOEmbed(
//         "https://graph.facebook.com/v12.0/oembed_video?url=$url",
//       );
//     } else if (url.contains('tiktok.com')) {
//       _platform = VideoPlatform.tiktok;
//       await _fetchOEmbed("https://www.tiktok.com/oembed?url=$url");
//     } else {
//       _error = "Unsupported platform";
//       _platform = VideoPlatform.unsupported;
//     }
//
//     if (mounted) setState(() => _initialized = true);
//   }
//
//   /// Initialize YouTube Player
//   void _initYouTube(String url) {
//     final videoId = YoutubePlayer.convertUrlToId(url);
//     if (videoId != null) {
//       _ytController =
//           YoutubePlayerController(
//             initialVideoId: videoId,
//             flags: YoutubePlayerFlags(
//               autoPlay: widget.autoPlay,
//               loop: widget.looping,
//               mute: false,
//               enableCaption: false,
//             ),
//           )..addListener(() {
//             if (_ytController!.value.hasError) {
//               setState(() => _error = "YouTube error");
//             }
//           });
//     } else {
//       _error = "Invalid YouTube URL";
//     }
//   }
//
//   /// Fetch oEmbed HTML for Instagram/Facebook/TikTok
//   Future<void> _fetchOEmbed(String apiUrl) async {
//     try {
//       final response = await http.get(Uri.parse(apiUrl));
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         _embedHtml = data['html'];
//       } else {
//         _error = "Failed to load embed (HTTP ${response.statusCode})";
//       }
//     } catch (e) {
//       _error = "Embed error: $e";
//     }
//   }
//
//   /// Open in external app/browser
//   Future<void> _launchExternal(String url) async {
//     final uri = Uri.parse(url);
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     } else {
//       setState(() => _error = "Cannot launch $url");
//     }
//   }
//
//   @override
//   void dispose() {
//     _ytController?.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (_error != null) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text("Error: $_error", style: const TextStyle(color: Colors.red)),
//             ElevatedButton(
//               onPressed: () => _launchExternal(widget.videoUrl),
//               child: const Text("Open in Browser"),
//             ),
//           ],
//         ),
//       );
//     }
//
//     if (!_initialized) {
//       return const Center(child: CircularProgressIndicator());
//     }
//
//     switch (_platform) {
//       case VideoPlatform.youtube:
//         return YoutubePlayer(
//           controller: _ytController!,
//           showVideoProgressIndicator: true,
//           progressIndicatorColor: Colors.red,
//         );
//
//       case VideoPlatform.instagram:
//       case VideoPlatform.facebook:
//       case VideoPlatform.tiktok:
//         if (_embedHtml != null) {
//           return WebViewWidget(
//             controller: WebViewController()
//               ..setJavaScriptMode(JavaScriptMode.unrestricted)
//               ..loadHtmlString(_embedHtml!),
//           );
//         } else {
//           return Center(
//             child: ElevatedButton(
//               onPressed: () => _launchExternal(widget.videoUrl),
//               child: const Text("Open Video"),
//             ),
//           );
//         }
//
//       default:
//         return Center(
//           child: ElevatedButton(
//             onPressed: () => _launchExternal(widget.videoUrl),
//             child: const Text("Open in Browser"),
//           ),
//         );
//     }
//   }
// }
