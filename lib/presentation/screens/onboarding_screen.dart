import 'package:concentric_transition/page_view.dart' show ConcentricPageView;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../core/constants/utils/extentions/Global_loc.dart';
import '../../data/models/OnboardingItem_Model.dart';
import '../../main.dart';
import 'home_screen.dart';


class OnboardingScreen extends StatefulWidget {
  final VoidCallback? onFinish; // سيتم تمرير الدالة للانتقال للصفحة الرئيسية

  const OnboardingScreen({super.key, this.onFinish});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _controller;
  final List<PageModel> pages = [];

  @override
  void initState() {
    super.initState();
    _controller = PageController();

    pages.addAll([
      PageModel(
        Image.asset('assets/images/image2.png', fit: BoxFit.cover),
        title: GlobalLoc.instance.onboarding1Title,
        subtitle:GlobalLoc.instance.onboarding1Description ,
        textColor: Colors.black87,
        icon: Icons.menu_book_rounded,
        bgColor: Colors.white,
      ),
      PageModel(
        Image.asset('assets/images/image3.jpg', fit: BoxFit.cover),
        title: GlobalLoc.instance.onboarding2Title,
        subtitle: GlobalLoc.instance.onboarding2Description,
        bgColor: Colors.white,
        textColor: Colors.black87,
        icon: Icons.chrome_reader_mode,
      ),
      PageModel(
        Image.asset('assets/images/image1.png', fit: BoxFit.cover),
        title: GlobalLoc.instance.onboarding3Title,
        subtitle: GlobalLoc.instance.onboarding3Description,
        bgColor: Colors.white,
        textColor: Colors.black87,
        icon: Icons.bookmark_added,
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ConcentricPageView(
                itemCount: pages.length,
                radius: w * 0.22,
                curve: Curves.fastOutSlowIn,
                duration: const Duration(milliseconds: 600,),
                verticalPosition: 0.8,
                colors: pages.map((p) => p.bgColor).toList(),
                itemBuilder: (index) {
                  final page = pages[index % pages.length];
                  final isLastPage = index == pages.length - 1;

                  return SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 150),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Container(
                            width: 400,
                            height: 370,
                            child: Opacity(opacity: 0.9, child: page.image),
                          ),
                        ),
                        SizedBox(height: h * 0.02),

                        // Title
                        Text(
                          page.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: w * 0.06,
                            fontWeight: FontWeight.w400,
                            color: page.textColor,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        SizedBox(height: h * 0.02),

                        // Subtitle
                        SizedBox(
                          width: 400,
                          child: Text(
                            page.subtitle,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: w * 0.035,
                              color: Colors.black54,
                            ),
                          ),
                        ),

                        // زر Get Started يظهر فقط في الصفحة الأخيرة
                        if (isLastPage) ...[
                          SizedBox(height: h * 0.05),
                          Container(
                            width: w * 0.6,
                            height: h * 0.057,
                            child: ElevatedButton(
                              onPressed: () {
                                Get.to(
                                  HomeScreen(),
                                  duration: Duration(milliseconds: 485),
                                  transition: Transition.rightToLeft,


                                );
                                getStorage.write('started', true);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: page.textColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                elevation: 5,
                              ),
                              child: Text(
                                 GlobalLoc.instance.onboardingButton,
                                style: TextStyle(
                                  fontSize: w * 0.033,
                                  fontWeight: FontWeight.w800,
                                  color: page.bgColor,
                                ),
                              ),
                            ),
                          ),
                        ],

                        SizedBox(height: h * 0.3), // بديل Spacer
                      ],
                    ),
                  );
                },
                pageController: _controller,
                onChange: (index) {
                  // إزالة الانتقال التلقائي من هنا
                  // سنعتمد فقط على الزر
                },
              ),
            ),

            // زر التخطي في الأعلى
            Positioned(
              top: h * 0.02,
              right: w * 0.05,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextButton(
                  onPressed: () {
                    Get.off(
                      HomeScreen(),
                      duration: Duration(milliseconds: 485),
                      transition: Transition.rightToLeft,

                    );
                    getStorage.write('started', true);
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: w * 0.04,
                      vertical: h * 0.01,
                    ),
                  ),
                  child: Text(
                    GlobalLoc.instance.skip,
                    style: TextStyle(
                      letterSpacing: 1,
                      fontSize: w * 0.04,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
