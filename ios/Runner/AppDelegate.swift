import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

// import UIKit
// import Flutter
// import MediaPlayer

// @UIApplicationMain
// @objc class AppDelegate: FlutterAppDelegate {
//     override func application(
//         _ application: UIApplication,
//         didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//     ) -> Bool {
//         GeneratedPluginRegistrant.register(with: self)
//         monitorPlaybackState()
//         return super.application(application, didFinishLaunchingWithOptions: launchOptions)
//     }

//     private func monitorPlaybackState() {
//         let commandCenter = MPRemoteCommandCenter.shared()
        
//         // Monitor play event
//         commandCenter.playCommand.addTarget { _ in
//             self.sendPlaybackStateChangeToFlutter(isPlaying: true)
//             return .success
//         }
        
//         // Monitor pause event
//         commandCenter.pauseCommand.addTarget { _ in
//             self.sendPlaybackStateChangeToFlutter(isPlaying: false)
//             return .success
//         }
//     }

//     private func sendPlaybackStateChangeToFlutter(isPlaying: Bool) {
//         // Send playback state (play/pause) to Flutter via platform channel
//         if let flutterViewController = window?.rootViewController as? FlutterViewController {
//             let channel = FlutterMethodChannel(name: "music_playback", binaryMessenger: flutterViewController.binaryMessenger)
//             channel.invokeMethod("playbackStateChanged", arguments: ["isPlaying": isPlaying])
//         }
//     }
// }

