import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:my_baseball_record/common/dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_remote_datasource.g.dart';

@RestApi()
abstract class AuthRemoteDatasource {
  factory AuthRemoteDatasource(Dio dio, {String baseUrl}) =
      _AuthRemoteDatasource;

  @POST('register')
  Future<TokenResponse> register(@Body() AuthAccountRequest accountRequest);
}

@JsonSerializable()
class AuthAccountRequest {
  final String email;
  final String password;

  AuthAccountRequest({required this.email, required this.password});

  factory AuthAccountRequest.fromJson(Map<String, dynamic> json) =>
      _$AuthAccountRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AuthAccountRequestToJson(this);
}

@JsonSerializable()
class TokenResponse {
  final String accessToken;

  TokenResponse({
    required this.accessToken,
  });

  factory TokenResponse.fromJson(Map<String, dynamic> json) =>
      _$TokenResponseFromJson(json);
}

final authRemoteDatasourceProvider = Provider<AuthRemoteDatasource>((ref) {
  final dio = ref.watch(dioProvider);

  final remoteDatasource = AuthRemoteDatasource(dio);

  return remoteDatasource;
});
