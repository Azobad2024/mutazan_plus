// import 'package:get/get.dart';
// import 'package:hive/hive.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import '../model/user_model.dart';
//
// class LoginController extends GetxController {
//   var isLoading = false.obs; // حالة التحميل
//   var errorMessage = ''.obs; // رسالة الخطأ
//
//   Future<void> login(String username, String password) async {
//     isLoading.value = true; // بدء التحميل
//     errorMessage.value = ''; // مسح رسائل الخطأ السابقة
//
//     try {
//       // إرسال طلب API لتسجيل الدخول
//       final response = await http.post(
//         Uri.parse('https://192.168.1.3:8000/api/token'),
//         body: {
//           'username': username,
//           'password': password,
//         },
//       );
//
//       if (response.statusCode == 200) {
//         // تسجيل الدخول ناجح
//         final data = json.decode(response.body);
//         final user = User(username: username, token: data['token']);
//
//         // Save user data to Hive
//         final userBox = Hive.box<User>('userBox');
//         userBox.put('currentUser', user);
//
//         Get.offNamed('/Home'); // الانتقال إلى الصفحة الرئيسية
//       } else {
//         // تسجيل الدخول فشل
//         errorMessage.value = 'Invalid username or password';
//       }
//     } catch (e) {
//       // خطأ في الاتصال بالـ API
//       errorMessage.value = 'An error occurred. Please try again.';
//     } finally {
//       isLoading.value = false; // إيقاف التحميل
//     }
//   }
// }
// /////////////////////////////////////////////////////////////////////



// import 'package:get/get.dart';
//
// class LoginController extends GetxController {
//   var isLoading = false.obs;
//
//   void login(String username, String password) async {
//     isLoading.value = true; // بدء التحميل
//     await Future.delayed(Duration(seconds: 2)); // محاكاة اتصال بالشبكة
//
//     if (username == "aaa" && password == "123") {
//       Get.offAllNamed('/Home'); // الانتقال إلى الصفحة الرئيسية
//     } else {
//       Get.snackbar('Error', 'Invalid username or password'); // عرض رسالة خطأ
//     }
//
//     isLoading.value = false; // إيقاف التحميل
//   }
// }