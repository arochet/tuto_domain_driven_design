import 'package:dartz/dartz.dart';
import 'package:tuto_domain_driven_design/domain/auth/auth_failure.dart';
import 'package:tuto_domain_driven_design/domain/auth/user.dart';
import 'package:tuto_domain_driven_design/domain/auth/value_objects.dart';

abstract class IAuthFacade {
  Future<Option<User>> getSignedUser();
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword(
      {required EmailAddress emailAdress, required Password password});
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword(
      {required EmailAddress emailAdress, required Password password});
  Future<Either<AuthFailure, Unit>> signInWithGoogle();
  Future<void> signOut();
}
