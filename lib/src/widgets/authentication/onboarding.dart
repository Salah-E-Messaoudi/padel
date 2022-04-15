import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
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
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(height: 20.sp),
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
                  OnboardingModule(
                    imagePath: 'assets/images/onboarding1.png',
                    title: AppLocalizations.of(context)!.onboarding_title_1,
                    subtitle:
                        AppLocalizations.of(context)!.onboarding_subtitle_1,
                  ),
                  OnboardingModule(
                    imagePath: 'assets/images/onboarding2.png',
                    title: AppLocalizations.of(context)!.onboarding_title_2,
                    subtitle:
                        AppLocalizations.of(context)!.onboarding_subtitle_2,
                  ),
                  OnboardingModule(
                    imagePath: 'assets/images/onboarding3.png',
                    title: AppLocalizations.of(context)!.onboarding_title_3,
                    subtitle:
                        AppLocalizations.of(context)!.onboarding_subtitle_3,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
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
                  CustomIconTextButton(
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
                    fontSize: 16.sp,
                    // fixedSize: Size(0.8.sw, 45.sp),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingModule extends StatelessWidget {
  const OnboardingModule({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
  }) : super(key: key);
  final String imagePath;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Image(
            image: AssetImage(imagePath),
            width: 1.sw - 50.w,
          ),
        ),
        SizedBox(height: 60.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.sp),
          child: Text(
            title,
            style: GoogleFonts.poppins(
              color: Theme.of(context).textTheme.headline1!.color,
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(height: 10.sp),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.sp),
          child: Text(
            subtitle,
            style: GoogleFonts.poppins(
              color: Theme.of(context).textTheme.headline2!.color,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(height: 40.h),
      ],
    );
  }
}
