mixin ValidationMixn {
   String? validateSongName(String? value) {
    if (value == null || value.isEmpty) return "Please enter song name";
   
    return null;
  }

  String? validateArtistName(String? value) {
    if (value == null || value.isEmpty) return "Please enter artist name";

    return null;
  }

  String? validateSongLink(String? value) {
    if (value == null || value.isEmpty) return "Please enter song link";
    return null;
  }

}