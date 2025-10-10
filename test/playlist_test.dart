import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/models/daos/fake_playlist_dao.dart';
import 'package:mobile_app/models/playlist.dart';
import 'package:mobile_app/models/playlists.dart';

void main() {
  group('FakePlaylistDAO', () {
    late FakePlaylistDAO dao;

    setUp(() {
      dao = FakePlaylistDAO();
    });

    test('getAllPlaylists retourne toutes les playlists', () async {
      Playlists playlists = await dao.getAllPlaylists();
      expect(playlists.playlists.length, 3);
      expect(playlists.playlists[0].name, 'Voiture');
    });

    test('getPlaylistById retourne la bonne playlist', () async {
      Playlist playlist = await dao.getPlaylistById('2');
      expect(playlist.name, 'Travail');
      expect(playlist.tracks.length, 2);
    });

    test('getPlaylistById lève une exception si l\'id n\'existe pas', () async {
      expect(() => dao.getPlaylistById('999'), throwsException);
    });
  });
}