import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_baseball_record/domain/auth/repository/datasource/auth_remote_datasource.dart';
import 'package:my_baseball_record/domain/auth/repository/model/token_model.dart';

abstract class AuthRepository {
  Future<TokenModel> register(AuthAccountRequest accountRequest);
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource _authRemoteDatasource;

  AuthRepositoryImpl(this._authRemoteDatasource);

  @override
  Future<TokenModel> register(AuthAccountRequest accountRequest) async {
    final tokenResponse = await _authRemoteDatasource.register(accountRequest);

    print(tokenResponse.accessToken);

    return TokenModel(accessToken: tokenResponse.accessToken);
  }
}

final authRepositoryImplProvider = Provider<AuthRepository>((ref) {
  final authRemoteDatasource = ref.watch(authRemoteDatasourceProvider);
  final repository = AuthRepositoryImpl(authRemoteDatasource);
  return repository;
});
