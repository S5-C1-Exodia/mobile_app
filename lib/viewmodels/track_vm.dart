import 'package:mobile_app/models/track.dart';

/// **TrackVM**
///
/// The **ViewModel** responsible for representing and managing the state
/// of a single track within the application.
///
/// This class is part of the **MVVM (Model-View-ViewModel)** architecture.
/// It serves as an intermediary between the [Track] model and the UI layer,
/// providing a clean and structured way to access track information
/// from the user interface.
///
/// While [TrackVM] currently acts as a simple wrapper around the [Track] model,
/// it can be extended to include additional UI-specific logic or computed properties.
class TrackVM {
  /// The underlying track model managed by this ViewModel.
  final Track model;

  /// Creates a new instance of [TrackVM] associated with the given [model].
  TrackVM({required this.model});
}
