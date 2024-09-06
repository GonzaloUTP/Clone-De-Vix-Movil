import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class LivePage extends StatefulWidget {
  @override
  _LivePageState createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  final PageController _pageController = PageController();

  final List<List<String>> videoPaths = [
    ['assets/1.mp4', 'assets/2.mp4', 'assets/3.mp4'],
    ['assets/1.mp4', 'assets/2.mp4', 'assets/3.mp4'],
    ['assets/1.mp4', 'assets/2.mp4', 'assets/3.mp4'],
    ['assets/1.mp4', 'assets/2.mp4', 'assets/3.mp4'],
    ['assets/1.mp4', 'assets/2.mp4', 'assets/3.mp4'],
    ['assets/1.mp4', 'assets/2.mp4', 'assets/3.mp4'],
  ];

  int currentListIndex = 0;
  int currentVideoIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(videoPaths[currentListIndex][currentVideoIndex])
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _togglePlay() {
    setState(() {
      _isPlaying = !_isPlaying;
      if (_isPlaying) {
        _controller.play();
      } else {
        _controller.pause();
      }
    });
  }

  void _changeVideo(int index) {
    setState(() {
      currentVideoIndex = index;
      _controller = VideoPlayerController.asset(videoPaths[currentListIndex][currentVideoIndex])
        ..initialize().then((_) {
          setState(() {});
          _controller.play();
        });
    });
  }

  void _changeVideoList(int index) {
    setState(() {
      currentListIndex = index;
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: GestureDetector(
              onTap: _togglePlay,
              child: _controller.value.isInitialized
                  ? VideoPlayer(_controller)
                  : Center(child: CircularProgressIndicator()),
            ),
          ),
          Container(
            color: Colors.black,
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildVideoListButton(0, 'Destacados'),
                  _buildVideoListButton(1, 'Noticias'),
                  _buildVideoListButton(2, 'Deportes'),
                  _buildVideoListButton(3, 'Comedia'),
                  _buildVideoListButton(4, 'Cine'),
                  _buildVideoListButton(5, 'Novelas'),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  currentListIndex = index;
                });
              },
              children: List.generate(videoPaths.length, (listIndex) {
                return _buildVideoListView(listIndex);
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoListButton(int index, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: OutlinedButton(
        onPressed: () => _changeVideoList(index),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.black,
          side: BorderSide(color: Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        child: Text(label),
      ),
    );
  }

  Widget _buildVideoListView(int listIndex) {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(videoPaths[listIndex].length, (index) {
          final programIndex = index + 1;
          return _buildLiveTile(
            leadingIcon: Icons.tv,
            title: 'Programa $programIndex',
            primarySubtitle: 'Programación',
            primarySubtitleColor: Colors.white,
            tileColor: index % 2 == 0 ? Colors.grey[900] : Colors.grey[850],
            onTap: () => _changeVideo(index),
          );
        }),
      ),
    );
  }

  Widget _buildLiveTile({
    required IconData leadingIcon,
    required String title,
    required String primarySubtitle,
    required Color primarySubtitleColor,
    Color? tileColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: tileColor ?? Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: tileColor,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(leadingIcon, color: Colors.orange, size: 40),
              SizedBox(width: 10), // Ajustar el espacio entre el icono y el texto
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    primarySubtitle,
                    style: TextStyle(color: primarySubtitleColor),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Video Player Example',
    home: LivePage(),
    theme: ThemeData.dark(),
  ));
}
