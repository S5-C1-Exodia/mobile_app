import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/models/daos/fake_user_dao.dart';

/// Unit tests for the FakeUserDAO class.
///
/// These tests ensure that FakeUserDAO correctly saves, retrieves,
/// and clears a simulated user session.
void main() {
  group('FakeUserDAO', () {
    // Instance of FakeUserDAO used for testing.
    final dao = FakeUserDAO();

    /// Test that verifies a saved session can be retrieved.
    test('save & get session', () async {
      await dao.saveSession('TestSaveSession');
      final session = await dao.getSession();
      expect(session, equals('TestSaveSession'));
    });

    /// Test that verifies the session is cleared after calling clearSession.
    test('erase session', () async {
      await dao.saveSession('TestEraseSession');
      await dao.clearSession();
      final session = await dao.getSession();
      expect(session, isNull);
    });
  });
}
