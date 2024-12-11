import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubeEmbeddedPlayerAPI extends StatefulWidget {
  const YouTubeEmbeddedPlayerAPI({super.key});

  @override
  _YouTubeEmbeddedPlayerAPIState createState() =>
      _YouTubeEmbeddedPlayerAPIState();
}

class _YouTubeEmbeddedPlayerAPIState extends State<YouTubeEmbeddedPlayerAPI> {
  YoutubePlayerController? _youtubePlayerController; // Change to nullable
  List<String> videoIds = [];
  String? currentVideoId; // Track the currently playing video ID
  final String apiKey =
      'AIzaSyBXghiWxfmFJfYBTvPCzqjohRySOJNmtt0'; // Replace with your API key
  final String playlistId =
      'PLw-LUSZrBbA3O2XRw6RCTcJJxnhITU_vT'; // Replace with your playlist ID

  // Function to fetch video IDs from the specified playlist
  Future<void> fetchPlaylistVideos() async {
    final url =
        'https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=50&playlistId=$playlistId&key=$apiKey';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final items = data['items'];

        setState(() {
          videoIds = items
              .map<String>(
                  (item) => item['snippet']['resourceId']['videoId'] as String)
              .toList();
        });
      } else {
        print('Failed to fetch videos: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error fetching playlist videos: $e');
    }
  }

  // Function to play a specific video
  void playVideo(String videoId) {
    setState(() {
      currentVideoId = videoId;
      if (_youtubePlayerController == null) {
        _youtubePlayerController = YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(
            autoPlay: true,
            mute: false,
          ),
        );
      } else {
        _youtubePlayerController!.load(videoId);
      }
    });
  }

  // Function to play a random video
  void playRandomVideo() {
    if (videoIds.isNotEmpty) {
      final random = Random();
      String randomVideoId;

      // Ensure the new video ID is different from the current one
      do {
        randomVideoId = videoIds[random.nextInt(videoIds.length)];
      } while (randomVideoId == currentVideoId);

      playVideo(randomVideoId);
    } else {
      print('No videos available to play.');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPlaylistVideos();
  }

  @override
  void dispose() {
    _youtubePlayerController
        ?.dispose(); // Dispose the controller when no longer needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Ensure the controller is not null before trying to display the player
          if (_youtubePlayerController != null)
            Expanded(
              child: YoutubePlayer(
                controller: _youtubePlayerController!,
                showVideoProgressIndicator: true,
                onReady: () {
                  print("Player is ready");
                },
              ),
            ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: playRandomVideo,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color.fromRGBO(155, 177, 103, 1),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(32), // Optional: rounded corners
              ),
            ),
            child: const Text('Play Next Video'),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
