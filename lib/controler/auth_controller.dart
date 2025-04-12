// import 'package:get/get.dart';
//
// class AuthController extends GetxController {
//   var isAuthenticated = false.obs;
//
//   void login(String email, String password) {
//     // هنا يتم استدعاء API أو Firebase لتسجيل الدخول
//     if (email == "ali" && password == "123") {
//       isAuthenticated.value = true;
//       Get.offAllNamed('/home'); // الانتقال للصفحة الرئيسية بعد النجاح
//     } else {
//       Get.snackbar("خطأ", "البريد الإلكتروني أو كلمة المرور غير صحيحة");
//     }
//   }
//
//   void logout() {
//     isAuthenticated.value = false;
//     Get.offAllNamed('/login'); // الرجوع لشاشة تسجيل الدخول
//   }
// }
