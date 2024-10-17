import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_app/controller/providers.dart';
import 'package:music_app/validation/validation.dart';
import 'package:music_app/values/color_scheme.dart';
import 'package:music_app/values/styles.dart';
import 'package:music_app/widgets/custom_appbar.dart';
import 'package:music_app/widgets/custom_btn.dart';
import 'package:music_app/widgets/custom_tf.dart';
import '../models/songs_model.dart';

class EditSongScreen extends ConsumerStatefulWidget {
  final bool isEdit; // To distinguish between add and edit mode
  final SongModel? song; // Song object in case of edit

  const EditSongScreen({required this.isEdit, this.song});

  @override
  _EditSongScreenState createState() => _EditSongScreenState();
}

class _EditSongScreenState extends ConsumerState<EditSongScreen>
    with ValidationMixn {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController artistController = TextEditingController();
  final TextEditingController urlController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.song != null) {
      // Prepopulate fields if editing an existing song
      nameController.text = widget.song!.name;
      artistController.text = widget.song!.artist;
      urlController.text = widget.song!.url;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leadingCallback: () => Navigator.pop(context),
        title: widget.isEdit ? "Edit Song" : "Add Song",
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Song Name:',
                style: Styles.customTextStylePopins(
                    fontSize: 16, color: CustomColorScheme.black),
              ),
              SizedBox(
                height: 5,
              ),
              CustomTextFieldWidget(
                controller: nameController,
                validation: validateSongName,
                hintText: 'Enter song name ',
                keyboard: TextInputType.text,
                style: Styles.customTextStylePopins(
                    fontSize: 14, color: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Artist Name:',
                style: Styles.customTextStylePopins(
                    fontSize: 16, color: CustomColorScheme.black),
              ),
              SizedBox(
                height: 5,
              ),
              CustomTextFieldWidget(
                controller: artistController,
                validation: validateArtistName,
                hintText: 'Enter artist name ',
                keyboard: TextInputType.text,
                style: Styles.customTextStylePopins(
                    fontSize: 14, color: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Song Link:',
                style: Styles.customTextStylePopins(
                    fontSize: 16, color: CustomColorScheme.black),
              ),
              SizedBox(
                height: 5,
              ),
              CustomTextFieldWidget(
                controller: urlController,
                validation: validateSongLink,
                hintText: 'Enter song link ',
                keyboard: TextInputType.text,
                style: Styles.customTextStylePopins(
                    fontSize: 14, color: Colors.white),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.center,
                child: CustomBtn(
                  color: CustomColorScheme.primary,
                  horizontalPadding: 0,
                  ontap: () {
                    FocusScope.of(context).unfocus();
                    if (formKey.currentState!.validate()) {
                      String name = nameController.text;
                      String artist = artistController.text;
                      String url = urlController.text;

                      if (name.isNotEmpty &&
                          artist.isNotEmpty &&
                          url.isNotEmpty) {
                        SongModel song = SongModel(
                          id: widget.song?.id,
                          name: name,
                          artist: artist,
                          url: url,
                        );

                        if (widget.isEdit) {
                          // Update the song in the database
                          ref
                              .read(songNotifierProvider.notifier)
                              .updateSong(song);
                        } else {
                          // Add the new song to the database
                          ref.read(songNotifierProvider.notifier).addSong(song);
                        }

                        Navigator.pop(
                            context); // Go back to the previous screen
                      }
                    }
                  },
                  title: widget.isEdit ? "Update Song" : "Add Song",
                ),
              )
              //
            ],
          ),
        ),
      ),
    );
  }
}
