/// A model class representing a user profile.
///
/// Contains information such as the user's unique identifier, name, age,
/// description, and the source URL of the profile image.
class Profile {
  final String id;
  final String userName;
  final int userAge;
  final String userDescription;
  final String profileImageSrc;

  /// Creates a [Profile] instance with the given properties.
  ///
  /// All parameters are required.
  Profile({
    required this.id,
    required this.userName,
    required this.userAge,
    required this.userDescription,
    required this.profileImageSrc,
  });

  /// Creates a [Profile] instance from a JSON map.
  ///
  /// [json] is a map containing the profile data.
  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      userName: json['userName'],
      userAge: json['userAge'],
      userDescription: json['userDescription'],
      profileImageSrc: json['profileImageSrc'],
    );
  }
}
