import 'package:flutter/material.dart';
import 'package:mutazan_plus/core/utils/app_text_styles.dart';
import 'package:mutazan_plus/features/on_boarding/data/models/on_boarding_model.dart';
import 'package:mutazan_plus/features/on_boarding/presentation/views/widgets/custom_smooth_page_indicator.dart';

class OnBoardingWidgetBody extends StatelessWidget {
  const OnBoardingWidgetBody({
    super.key,
    required this.controller,
    this.onPageChanged,
  });
  final PageController controller;
  final Function(int)? onPageChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: PageView.builder(
        onPageChanged: onPageChanged,
        physics: const BouncingScrollPhysics(),
        controller: controller,
        itemCount: onBoardingData.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                height: 290,
                width: 343,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(onBoardingData[index].imagePath),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              CustomSmoothPageIndicator(controller: controller),
              const SizedBox(height: 24),
              Text(
                onBoardingData[index].title,
                style: CustomTextStyles.khandevane500style24.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          );
        },
      ),
    );
  }
}
