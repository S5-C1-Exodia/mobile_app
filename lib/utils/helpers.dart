import '../models/playlist.dart';
import '../models/track.dart';

/// Asynchronously fetches a list of playlists.
///
/// Simulates a network delay of 1 second, then returns a list of [Playlist] objects
/// with predefined data, including tracks and image URLs.
///
/// Returns a [Future] that completes with a list of [Playlist]s.
Future<List<Playlist>> fetchPlaylists() async {
  await Future.delayed(Duration(seconds: 1));
  return [
    Playlist(
      id: '1',
      name: 'Top Hits',
      imageUrl: 'https://i.scdn.co/image/ab67706f00000002c4e7b6e6e6e6e6e6e6e6e6',
      tracks: [
        Track(title: 'Song 1', artist: 'Artist A'),
        Track(title: 'Song 2', artist: 'Artist B'),
      ], autor: '',
    ),
    Playlist(
      id: '2',
      name: 'Chill Vibes',
      imageUrl: 'https://i.scdn.co/image/ab67706f00000002b4e7b6e6e6e6e6e6e6e6e6',
      tracks: [
        Track(title: 'Song 3', artist: 'Artist C'),
        Track(title: 'Song 4', artist: 'Artist D'),
      ], autor: '',
    ),
  ];
}