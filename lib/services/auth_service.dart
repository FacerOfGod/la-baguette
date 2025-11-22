import 'package:baguette/models/user_model.dart';

abstract class AuthService {
  Future<AppUser?> signInWithEmail(String email, String password);
  Future<AppUser?> signUpWithEmail(
    String email,
    String password,
    String username,
  );
  Future<void> signOut();
  Stream<AppUser?> get authStateChanges;
  AppUser? get currentUser;
}

class MockAuthService implements AuthService {
  AppUser? _currentUser;

  @override
  AppUser? get currentUser => _currentUser;

  @override
  Stream<AppUser?> get authStateChanges => Stream.value(_currentUser);

  @override
  Future<AppUser?> signInWithEmail(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    if (email == 'test@test.com' && password == 'password') {
      _currentUser = AppUser(
        id: 'user_123',
        email: email,
        username: 'Citoyen Test',
        city: 'Paris',
      );
      return _currentUser;
    }
    throw Exception('Invalid credentials');
  }

  @override
  Future<AppUser?> signUpWithEmail(
    String email,
    String password,
    String username,
  ) async {
    await Future.delayed(const Duration(seconds: 1));
    _currentUser = AppUser(
      id: 'user_new_${DateTime.now().millisecondsSinceEpoch}',
      email: email,
      username: username,
    );
    return _currentUser;
  }

  @override
  Future<void> signOut() async {
    _currentUser = null;
  }
}
