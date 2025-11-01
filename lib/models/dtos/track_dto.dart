/// **TrackDTO**
///
/// A **Data Transfer Object (DTO)** that represents a single track (song)
/// within a playlist.  
/// This class is used to transfer track-related data between different
/// layers of the application, such as between the data layer and
/// the presentation layer.
///
/// It contains only the essential fields needed to display or process
/// track information, without including any business logic.
class TrackDTO {
  /// The unique identifier of the track.
  final String id;

  /// The title or name of the track.
  final String title;

  /// The album to which this track belongs.
  final String album;

  /// The artist or performer of the track.
  final String artist;

  /// The URL of the album cover or track image.
  final String urlImage;

  /// Creates a new instance of [TrackDTO] with the specified properties.
  TrackDTO({
    required this.id,
    required this.title,
    required this.album,
    required this.artist,
    required this.urlImage,
  });
}
