Music App

Overview
This Flutter application allows users to manage and play songs with a simple CRUD (Create, Read, Update, Delete) interface using an SQLite database. Users can add, update, delete, and retrieve songs from the local database. It also supports audio playback using the audioplayers package, with background services that display a notification when a song is playing.

Features:
CRUD Operations: Add, delete, update, and retrieve songs from the local SQLite database.
Song Management: Each song requires a name, artist, and URL for the audio file.
Music Playback: Play songs using the audioplayers package.
Background Playback: Show notifications with the currently playing song using a MethodChannel.
Persistent Storage: Use sqflite for storing song data and path_provider for accessing the device's local storage.


Getting Started
Follow these instructions to get a copy of the project up and running on your local machine.

Prerequisites
Ensure you have Flutter installed. Follow the Flutter setup guide:



Flutter Installation Guide

Installation
Clone the repository:
git clone https://github.com/shahidx-iqbal/music_app_task.git


Navigate into the project directory:
cd your-repo-name


Install the dependencies:
flutter pub get
Run the app:
flutter run


Dependencies
This app uses the following packages:

sqflite: For SQLite database operations.
path_provider: For accessing the device's file system.
flutter_riverpod: For state management.
audioplayers: For audio playback.
google_fonts: For custom fonts.

Folder Structure

lib/
├── controllers/        # Riverpod Controllers for managing app state
├── models/             # Data models used in the app
├── services/           # API and background service integration (MethodChannel)
├── views/              # UI screens and widgets
├── widgets/            # Reusable custom widgets
├── validation/         # Input validation logic for forms
├── values/             # Color scheme and style file
│   ├── color_scheme.dart    # Contains color schemes for the app
│   ├── styles.dart          # Text styles and themes
├── main.dart           # Entry point of the application