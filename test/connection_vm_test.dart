import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_app/viewmodels/connexion_vm.dart';
import 'package:mobile_app/models/daos/fake_user_dao.dart';

/// Entry point for unit tests of ConnexionVM using FakeUserDAO.
void main() {
  // Initializes the binding required for Flutter widget tests.
  TestWidgetsFlutterBinding.ensureInitialized();

  /// Test group for ConnexionVM with FakeUserDAO.
  group('ConnexionVM Tests (FakeUserDAO)', () {
    late ConnexionVM connexionVM;
    late FakeUserDAO fakeDAO;

    /// Sets up a new instance of FakeUserDAO and ConnexionVM before each test.
    setUp(() {
      fakeDAO = FakeUserDAO();
      connexionVM = ConnexionVM(fakeDAO);
    });

    /// Tests that a successful connection updates the session and state.
    test('Successful connection updates session and states', () async {
      await connexionVM.connect();
      final session = await fakeDAO.getSession();
      expect(session, isNotNull);
      expect(connexionVM.state, equals('session_test'));
    });

    /// Tests that disconnecting removes the session and updates states.
    test('Disconnect removes session and updates states', () async {
      await fakeDAO.saveSession('session_test');
      await connexionVM.disconnect();
      final session = await fakeDAO.getSession();
      expect(session, isNull);
      expect(connexionVM.isConnected, false);
      expect(connexionVM.errorMessage, isNull);
    });

    /// Tests error handling during a failed connection attempt.
    test('Error handling during connection', () async {
      fakeDAO.shouldFail = true;
      await connexionVM.connect();
      expect(connexionVM.isLoading, false);
      expect(connexionVM.isConnected, false);
      expect(connexionVM.errorMessage, isNotNull);
    });

    /// Tests that isLoading is false after the connection attempt.
    test('isLoading is false after connection', () async {
      await connexionVM.connect();
      expect(connexionVM.isLoading, false);
    });
  });
}
