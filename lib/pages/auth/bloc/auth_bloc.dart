import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../packages/repositories/user_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository _userRepository;

  AuthBloc({UserRepository? userRepository})
    : _userRepository = userRepository ?? UserRepository(),
      super(const AuthInitial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthLoginRequested>(_onAuthLoginRequested);
    on<AuthSignupRequested>(_onAuthSignupRequested);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
  }

  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      final user = _userRepository.currentUser;
      if (user != null) {
        emit(AuthAuthenticated(userId: user.uid, email: user.email ?? ''));
      } else {
        emit(const AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> _onAuthLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      final userCredential = await _userRepository.signInWithEmailAndPassword(
        event.email,
        event.password,
      );
      final user = userCredential.user;
      if (user != null) {
        emit(AuthAuthenticated(userId: user.uid, email: user.email ?? ''));
      } else {
        emit(const AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> _onAuthSignupRequested(
    AuthSignupRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      final userCredential = await _userRepository
          .createUserWithEmailAndPassword(event.email, event.password);
      final user = userCredential.user;
      if (user != null) {
        // Create user profile in Firestore
        await _userRepository.createUserProfile(
          uid: user.uid,
          email: event.email,
        );
        emit(AuthAuthenticated(userId: user.uid, email: user.email ?? ''));
      } else {
        emit(const AuthUnauthenticated());
      }
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      await _userRepository.signOut();
      emit(const AuthUnauthenticated());
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }
}
