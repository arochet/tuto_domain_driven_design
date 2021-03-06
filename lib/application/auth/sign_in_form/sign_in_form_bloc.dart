import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:tuto_domain_driven_design/domain/auth/auth_failure.dart';
import 'package:tuto_domain_driven_design/domain/auth/i_auth_facade.dart';
import 'package:tuto_domain_driven_design/domain/auth/value_objects.dart';

part 'sign_in_form_event.dart';
part 'sign_in_form_state.dart';
part 'sign_in_form_bloc.freezed.dart';

@injectable
class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {
  final IAuthFacade _authFacade;

  SignInFormBloc(this._authFacade) : super(SignInFormState.initial());

  @override
  Stream<SignInFormState> mapEventToState(
    SignInFormEvent event,
  ) async* {
    print("Sigin in bloc");
    yield* event.map(emailChanged: (e) async* {
      yield state.copyWith(
          emailAddress: EmailAddress(e.emailStr),
          authFailureOrSuccessOption: none());
    }, passwordChanged: (e) async* {
      yield state.copyWith(
          password: Password(e.passwordStr),
          authFailureOrSuccessOption: none());
    }, registerWithEmailAndPasswordPressed: (e) async* {
      yield* _performActionOnAuthFacadeWithEmailAndPassword(
          this._authFacade.registerWithEmailAndPassword);
    }, signInWithEmailAndPasswordPressed: (e) async* {
      yield* _performActionOnAuthFacadeWithEmailAndPassword(
          this._authFacade.signInWithEmailAndPassword);
    }, signInWithGooglePressed: (e) async* {
      yield state.copyWith(
          isSubmitting: true, authFailureOrSuccessOption: none());
      final failureOrSuccess = await _authFacade.signInWithGoogle();
      yield state.copyWith(
          isSubmitting: false,
          authFailureOrSuccessOption:
              failureOrSuccess != null ? some(failureOrSuccess) : none());
    });
  }

  Stream<SignInFormState> _performActionOnAuthFacadeWithEmailAndPassword(
      Future<Either<AuthFailure, Unit>> Function(
              {required EmailAddress emailAdress, required Password password})
          forwardedCall) async* {
    Either<AuthFailure, Unit>? failureOrSuccess;

    final isEmailValid = state.emailAddress.isValid();
    final isPasswordValid = state.password.isValid();
    if (isEmailValid && isPasswordValid) {
      yield state.copyWith(
          isSubmitting: true, authFailureOrSuccessOption: none());

      failureOrSuccess = await forwardedCall(
          emailAdress: state.emailAddress, password: state.password);
    }

    yield state.copyWith(
        isSubmitting: false,
        showErrorMessages: true,
        authFailureOrSuccessOption: failureOrSuccess != null
            ? some(failureOrSuccess)
            : none()); //optionOf -> value != null ? some(value) : none();     |??optionOf ne fonctionne pas
  }
}
