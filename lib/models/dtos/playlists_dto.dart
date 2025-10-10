import 'package:mobile_app/models/dtos/playlist_dto.dart';

/// **PlaylistsDTO**
///
/// A **Data Transfer Object (DTO)** that represents a collection of playlists.
/// This class is typically used to encapsulate multiple [PlaylistDTO] objects
/// when transferring data between the data layer and higher layers
/// (e.g., view models or UI components).
///
/// It helps maintain a consistent structure when handling grouped playlist data,
/// such as API responses or DAO outputs.
class PlaylistsDTO {
  /// The list of all playlists included in this data object.
  final List<PlaylistDTO> playlists;

  /// Creates a new instance of [PlaylistsDTO] with the specified [playlists].
  PlaylistsDTO({required this.playlists});
}
