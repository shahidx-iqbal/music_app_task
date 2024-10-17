import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/models/songs_model.dart';
import 'package:music_app/services/background_service.dart';
import 'package:music_app/values/color_scheme.dart';
import 'package:music_app/values/styles.dart';
import 'package:music_app/views/update_song_view.dart';

class SongTile extends ConsumerStatefulWidget {
  final SongModel song;
  final int index;
  final Function onDelete;

  const SongTile({
    Key? key,
    required this.song,
    required this.index,
    required this.onDelete,
  }) : super(key: key);

  @override
  _SongTileState createState() => _SongTileState();
}

class _SongTileState extends ConsumerState<SongTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool isPlaying = false;
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  Future<void> _togglePlay() async {
    // Toggle the play state of the current song
    setState(() {
      isPlaying = !isPlaying;
    });

    if (isPlaying) {
      // Play the  song
      await player.play(UrlSource(widget.song.url));
      _controller.forward();
      // Optionally, start the music service to handle background tasks
      await MusicService()
          .startService(widget.song.name, widget.song.artist, true);
    } else {
      // Stop the current song
      await player.stop();

      // Optionally, stop the music service when the song stops
      await MusicService()
          .stopService(widget.song.name, widget.song.artist, false);

      // Reverse the card's animation when the song stops
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          _navigateToEditScreen(context, isEdit: true, song: widget.song),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Card(
          color: CustomColorScheme.cardColor,
          elevation: 5,
          shadowColor: CustomColorScheme.primary,
          margin: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Static image url is used for all cards
              Expanded(
                child: Image.network(
                  'https://static.vecteezy.com/system/resources/previews/046/437/292/non_2x/itunes-music-icon-free-png.png',
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Song: ',
                            style: Styles.customTextStylePopins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: CustomColorScheme.primary,
                            ),
                          ),
                          Text(
                            widget.song.name,
                            style: Styles.customTextStylePopins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: CustomColorScheme.primary,
                            ),
                            // softWrap: true,
                            // overflow: TextOverflow.ellipsis,
                            // maxLines: 1,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Artist: ',
                            style: Styles.customTextStylePopins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: CustomColorScheme.primary,
                            ),
                          ),
                          Text(
                            widget.song.artist,
                            style: Styles.customTextStylePopins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: CustomColorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      color: CustomColorScheme.white,
                    ),
                    onPressed: _togglePlay,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: CustomColorScheme.white,
                    ),
                    onPressed: () {
                      if (widget.song.id != null) {
                        widget.onDelete(widget.song.id!.toInt());
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToEditScreen(BuildContext context,
      {required bool isEdit, SongModel? song}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditSongScreen(isEdit: isEdit, song: song),
      ),
    );
  }
}
