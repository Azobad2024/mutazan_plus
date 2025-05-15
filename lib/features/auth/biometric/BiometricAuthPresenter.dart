import 'package:local_auth/local_auth.dart';
import 'package:mutazan_plus/features/auth/biometric/BiometricAuthInterface.dart';

class BiometricAuthPresenter {
  final BiometricAuthInterface biometricAuth;

  BiometricAuthPresenter(this.biometricAuth);

  Future<bool>authenticate() async {
    return await biometricAuth.authenticate();
  }

  Future<List<BiometricType>> getAvailableBiometrics() async {
    return await biometricAuth.getAvailableBiometrics();
  }
}