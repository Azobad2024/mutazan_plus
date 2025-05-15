// lib/features/home/presentation/views/home_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mutazan_plus/core/utils/app_colors.dart';
import 'package:mutazan_plus/core/widgets/custom_navbar.dart';
import 'package:mutazan_plus/features/controler/home_controller.dart';
import 'package:mutazan_plus/features/home/presentation/cubit/home_cubit.dart';
import 'package:mutazan_plus/features/home/presentation/widgets/StatsRowWidget.dart';
import 'package:mutazan_plus/features/home/presentation/widgets/footer_widget.dart';
import 'package:mutazan_plus/features/home/presentation/widgets/header_row_widget.dart';
import 'package:mutazan_plus/features/home/presentation/widgets/header_widget.dart';
import 'package:mutazan_plus/core/widgets/container_radius.dart';
import 'package:mutazan_plus/features/home/presentation/widgets/home_body.dart';
import 'package:mutazan_plus/view/widgets/StatsWidget.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return BlocProvider(
      create: (context) => NavCubit(),
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          automaticallyImplyLeading: false,
          title: const HeaderWidget(),
        ),
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10),
              const StatsWidget(), // الإحصائيات فوق ContainerRadius
              const SizedBox(height: 10),
              const FooterWidget(), // التذييل فوق ContainerRadius
              const SizedBox(height: 2),
              Expanded(
                child: ContainerRadius(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: const [
                        SizedBox(height: 16),
                        StatsRowWidget(),
                        SizedBox(height: 10),
                        HeaderRowWidget(),
                        SizedBox(height: 6),
                        Expanded(child: HomeBody()),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          color: AppColors.White,
          padding: const EdgeInsets.symmetric(vertical: 0),
          child: const NavigationBarItems(showBarcode: false),
        ),
        // bottomNavigationBar: Obx(() {
        //   // final idx = Get.find<HomeController>().selectedIndex.value;
        //   return Container(
        //     color: AppColors.White,
        //     padding: const EdgeInsets.symmetric(vertical: 0),
        //     child: NavigationBarItems(
        //       // selectedIndex: idx,
        //       showBarcode: false,
        //     ),
        //   );
        // }),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:mutazan_plus/core/utils/app_colors.dart';
// import 'package:mutazan_plus/features/home/presentation/widgets/footer_widget.dart';
// import 'package:mutazan_plus/features/home/presentation/widgets/header_widget.dart';
// import 'package:mutazan_plus/features/home/presentation/widgets/home_body.dart';
// import 'package:mutazan_plus/view/widgets/StatsWidget.dart';
// import 'package:mutazan_plus/core/widgets/container_radius.dart';

// class Home extends StatelessWidget {
//   // static String routeName = "/Home";

//   const Home({super.key});

//   @override
//   Widget build(BuildContext context) {
//         print('✅ تم بناء الصفحة الرئيسية');

//     return Scaffold(
//       backgroundColor: AppColors.backgroundColor, // اللون الأساسي للخلفية
//       appBar: AppBar(
//         backgroundColor: AppColors.backgroundColor,
//         automaticallyImplyLeading: false, // إخفاء سهم العودة
//         title: HeaderWidget(), // إضافة HeaderWidget في العنوان
//       ),
//       body: const SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(height: 10),
//             // HeaderWidget(), // عنصر الرأس
//             SizedBox(height: 10),
//             StatsWidget(), // عنصر الإحصائيات
//             // const SizedBox(height: 2,), // للحفاظ على توزيع المساحة
//             FooterWidget(), // عنصر التذييل
//             SizedBox(height: 2),
//             // محتويات ContainerRadius
//             Expanded(
//               child: ContainerRadius(
//                 child: Homebody(),
//               ),
//             ),
//           ],
//         ),
//       ),
//       // الخلفية البيضاء للجزء السفلي
//       // bottomNavigationBar: Stack(
//       //   children: [
//       //     Container(
//       //       height: 60, // ارتفاع الجزء الأبيض
//       //       color: Colors.white, // لون الخلفية السفلية
//       //     ),
//       //     NavigationBarItems(selectedIndex: 0),
//       //   ],
//       // ),
//     );
//   }
// }