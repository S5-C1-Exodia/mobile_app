import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/viewmodels/connexion_vm.dart';
import 'package:mobile_app/models/daos/fake_user_dao.dart';

void main() {
  group('ConnexionVM Tests (FakeUserDAO)', () {
    late ConnexionVM connexionVM;
    late FakeUserDAO fakeDAO;

    setUp(() {
      fakeDAO = FakeUserDAO();
      connexionVM = ConnexionVM(fakeDAO);
    });

    test('Connection create a session and launch an URL', () async {
      await connexionVM.connect();
      final session = await fakeDAO.getSession();
      expect(session, isNotNull);
      expect(connexionVM.isLoading, false);
      expect(connexionVM.errorMessage, isNull);
    });

    test('Deconnection delete the session', () async {
      await connexionVM.connect();
      await connexionVM.disconnect();

      final session = await fakeDAO.getSession();
      expect(session, isNull);
      expect(connexionVM.isConnected, false);
      expect(connexionVM.errorMessage, isNull);
    });

    test('Erro gestion : unexisting session during handleCallback', () async {
      await connexionVM.handleCallback('fake_code');
      expect(connexionVM.errorMessage, isNotNull);
    });
  });
}