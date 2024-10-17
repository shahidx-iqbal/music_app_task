import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/controller/providers.dart';
import 'package:music_app/models/songs_model.dart';
import 'package:music_app/values/color_scheme.dart';
import 'package:music_app/views/song_tile.dart';
import 'package:music_app/views/update_song_view.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:music_app/widgets/custom_appbar.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Set screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;


    // Watch the list of songs
    final songList = ref.watch(songNotifierProvider);

    return Scaffold(
      appBar:const CustomAppBar(title: 'Songs List'),
      body: songList.isEmpty
          ? const Center(child: Text("No songs available"))
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Adjust the number of columns
                childAspectRatio: 0.8, // Adjust the aspect ratio for card size
              ),
              itemCount: songList.length,
              itemBuilder: (context, index) {
                final song = songList[index];
                return _songListTile(song, index, context);
              },
            ),
      // Floating action button to add a new song
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColorScheme.primary,
        foregroundColor: CustomColorScheme.white,
        
        onPressed: () {
          // Navigate to the Edit Song Screen for adding a new song
          _navigateToEditScreen(context, isEdit: false);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  // Function to handle navigation to the edit screen
void _navigateToEditScreen(BuildContext context,
    {required bool isEdit, SongModel? song}) {
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => EditSongScreen(
        isEdit: isEdit,
        song: song,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // Start the transition from the right
        const end = Offset.zero; 
        const curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    ),
  );
}


Widget _songListTile(SongModel song, int index, BuildContext context) {
  return SongTile(
    song: song,
    index: index,
    onDelete: (id) {
      ref.read(songNotifierProvider.notifier).deleteSong(id);
    },
  );
}
}
