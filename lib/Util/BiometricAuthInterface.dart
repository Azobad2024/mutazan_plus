import 'package:local_auth/local_auth.dart';

abstract class BiometricAuthInterface {
  Future<bool> authenticate();
  Future<List<BiometricType>> getAvailableBiometrics();
}