import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_baseball_record/common/const/data.dart';
import 'package:my_baseball_record/common/secure_storage/secure_storage.dart';
import 'package:my_baseball_record/domain/auth/repository/auth_repository.dart';
import 'package:my_baseball_record/domain/auth/repository/datasource/auth_remote_datasource.dart';

abstract class AuthService {
  Future<void> register(String email, String password);
}

class AuthServiceImpl implements AuthService {
  final AuthRepository _authRepository;
  final FlutterSecureStorage _flutterSecureStorage;

  AuthServiceImpl(this._authRepository, this._flutterSecureStorage);

  @override
  Future<void> register(String email, String password) async {
    final tokenModel = await _authRepository
        .register(AuthAccountRequest(email: email, password: password));

    final accessToken = tokenModel.accessToken;
    await _flutterSecureStorage.write(
        key: ACCESS_TOKEN_KEY, value: accessToken);
  }
}

final authServiceImplProvider = Provider<AuthService>((ref) {
  final authRepository = ref.watch(authRepositoryImplProvider);
  final flutterSecureStorage = ref.watch(secureStorageProvider);
  return AuthServiceImpl(authRepository, flutterSecureStorage);
});
