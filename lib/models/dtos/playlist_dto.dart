import 'package:mobile_app/models/dtos/track_dto.dart';

/// **PlaylistDTO**
///
/// A **Data Transfer Object (DTO)** representing a playlist.
/// This class is used to carry playlist data between layers of the application,
/// such as between the data layer (DAO) and the view model.
///
/// Unlike business models, DTOs are typically lightweight and contain only
/// the information necessary for data exchange or serialization.
class PlaylistDTO {
  /// The unique identifier of the playlist.
  final String id;

  /// The display name of the playlist.
  final String name;

  /// The name or ID of the playlist’s owner or creator.
  final String owner;

  /// The URL of the playlist’s cover image.
  final String imageUrl;

  /// The list of tracks contained in the playlist.
  ///
  /// Each track is represented as a [TrackDTO].
  final List<TrackDTO> tracks;

  /// Creates a new instance of [PlaylistDTO] with the given properties.
  PlaylistDTO({
    required this.id,
    required this.name,
    required this.owner,
    required this.imageUrl,
    required this.tracks,
  });
}
