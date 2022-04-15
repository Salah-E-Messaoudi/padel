import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:padel/src/widgets/widget_models.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({
    Key? key,
    required this.setShowOnboarding,
  }) : super(key: key);

  final void Function() setShowOnboarding;
  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  PageController _pageController = PageController();
  int currentIndex = 0;
  int nbPages = 3;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 120.h),
          SizedBox(
            height: 540.h,
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                if ((currentIndex < nbPages - 1) ||
                    (currentIndex < nbPages && index < nbPages - 1)) {
                  setState(() {
                    currentIndex = index;
                  });
                } else {
                  currentIndex = index;
                }
              },
              children: [
                OnboardingWidget(
                  imagePath: 'assets/images/onboarding1.png',
                  title: AppLocalizations.of(context)!.onboarding_title_1,
                  subtitle: AppLocalizations.of(context)!.onboarding_subtitle_1,
                ),
                OnboardingWidget(
                  imagePath: 'assets/images/onboarding2.png',
                  title: AppLocalizations.of(context)!.onboarding_title_2,
                  subtitle: AppLocalizations.of(context)!.onboarding_subtitle_2,
                ),
                OnboardingWidget(
                  imagePath: 'assets/images/onboarding3.png',
                  title: AppLocalizations.of(context)!.onboarding_title_3,
                  subtitle: AppLocalizations.of(context)!.onboarding_subtitle_3,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 25.w,
                vertical: MediaQuery.of(context).viewInsets.bottom + 20.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SmoothPageIndicator(
                  controller: _pageController,
                  count: nbPages,
                  effect: ExpandingDotsEffect(
                    activeDotColor: Theme.of(context).primaryColor,
                    dotColor: Theme.of(context).textTheme.headline4!.color!,
                    dotHeight: 10.sp,
                    dotWidth: 10.sp,
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  width: currentIndex < nbPages - 1 ? 100.sp : 150.sp,
                  child: CustomIconTextButton(
                    label: currentIndex < nbPages - 1
                        ? AppLocalizations.of(context)!.next
                        : AppLocalizations.of(context)!.get_started,
                    onPressed: () {
                      if (currentIndex < nbPages - 1) {
                        _pageController.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut);
                      } else {
                        widget.setShowOnboarding();
                      }
                    },
                    fontColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
