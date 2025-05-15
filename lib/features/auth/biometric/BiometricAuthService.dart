import 'package:local_auth/local_auth.dart';

import 'BiometricAuthInterface.dart';

class BiometricAuthService implements BiometricAuthInterface {
  final LocalAuthentication _localAuth = LocalAuthentication();

  @override
  Future<bool> authenticate() async {
    return await _localAuth.authenticate(
        localizedReason: 'Please authenticate to access the app',
    options: const AuthenticationOptions(
      useErrorDialogs: true,
      stickyAuth: true,
    ),
    );
  }

  @override
  Future<List<BiometricType>> getAvailableBiometrics() async {
    return await _localAuth.getAvailableBiometrics();
  }
}