import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:todo/features/authentication/services/auth_service.dart';

class MockAuthService extends Mock implements AuthService {}

void main() {
  late AuthBloc authBloc;
  late MockAuthService mockAuthService;

  setUp(() {
    mockAuthService = MockAuthService();
    authBloc = AuthBloc(authService: mockAuthService);
  });

  tearDown(() {
    authBloc.close();
  });

  group('AuthBloc', () {
    test('initial state is Initial', () {
      expect(authBloc.state, isA<Initial>());
    });

    blocTest<AuthBloc, AuthState>(
      'emits Loading and then SignInSuccessful when sign in is successful',
      build: () {
        when(() => mockAuthService.signIn(
          email: any(named: 'email'),
          password: any(named: 'password'),
        )).thenAnswer((_) async {});
        return authBloc;
      },
      act: (bloc) => bloc.add(SignIn()),
      expect: () => [
        isA<Loading>(),
        isA<SignInSuccessful>(),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits Loading and then AuthError when sign in fails',
      build: () {
        when(() => mockAuthService.signIn(
          email: any(named: 'email'),
          password: any(named: 'password'),
        )).thenThrow(FirebaseAuthException(
          code: 'wrong-password',
          message: 'Wrong password provided.',
        ));
        return authBloc;
      },
      act: (bloc) => bloc.add(SignIn()),
      expect: () => [
        isA<Loading>(),
        isA<AuthError>()
            .having((e) => e.message, 'message', 'Wrong password provided.')
            .having((e) => e.code, 'code', 'wrong-password'),
      ],
    );
  });
}
