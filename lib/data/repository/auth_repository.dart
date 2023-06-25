import 'package:dartz/dartz.dart';
import 'package:tech_test/core/utils/failure/failure.dart';
import 'package:tech_test/data/model/auth.dart';

abstract class AuthRepository {
  Future<Either<Failure, Authentication>> login(
      {required String email, required String password});

  Future<Either<Failure, bool>> logout();
}
