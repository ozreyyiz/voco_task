import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:voco_task/view/login_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/auth_manager.dart';
import '../../model/user_model.dart';
import '../participants_page.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  Future<void> controlToLogin() async {
    await ref.read(AuthProvider).fetchUserLogin();
    if (ref.read(AuthProvider).isLogin) {
      await Future.delayed(const Duration(seconds: 1));
      ref.read(AuthProvider).userModel = UserModel();

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const ParticipantsPage()));
    } else {
      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(
          context, (MaterialPageRoute(builder: (context) => const LoginPage())));
    }
  }

  final pageController = PageController();
  bool isLastPage = false;
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (index) => setState(() {
              isLastPage = index == 2;
            }),
            children: [
              Container(
                decoration: onboardingPageDecoration(
                  imgsrc:
                      "https://images.pexels.com/photos/5553094/pexels-photo-5553094.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                ),
                child: const DesignOnBoarding(
                  widget: OnboardingText(
                    thinText: "Let's find",
                    boldText: "new friends",
                  ),
                ),
              ),
              Container(
                decoration: onboardingPageDecoration(
                    imgsrc:
                        "https://images.pexels.com/photos/4004112/pexels-photo-4004112.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                child: const DesignOnBoarding(
                  widget: OnboardingText(
                    thinText: "Fun       ",
                    boldText: "everytime.",
                  ),
                ),
              ),
              Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  decoration: onboardingPageDecoration(
                      imgsrc:
                          "https://images.pexels.com/photos/2261016/pexels-photo-2261016.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                  child: const DesignOnBoarding(
                      widget: OnboardingText(
                    thinText: "Explore the       ",
                    boldText: "Beautiful world!",
                  ))),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              isLastPage
                  ? Center(
                      child: TemplateButton(
                        borderRadius: BorderRadius.circular(10),
                        height: 50,
                        width: size.width / 2,
                        size: size,
                        child: OnboardingGetStartedButton(
                          function: () {
                            controlToLogin();
                          },
                        ),
                      ),
                    )
                  : Center(
                      child: SmoothPageIndicator(
                        controller: pageController,
                        count: 3,
                        effect: WormEffect(
                          spacing: 20,
                          dotColor: Colors.amber.withOpacity(0.6),
                          activeDotColor: Colors.white,
                        ),
                        onDotClicked: (index) => pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        ),
                      ),
                    ),
              const SizedBox(height: 50),
            ],
          ),
        ],
      ),
    );
  }

  BoxDecoration onboardingPageDecoration({required String imgsrc}) {
    return BoxDecoration(
      image: DecorationImage(
        colorFilter: ColorFilter.mode(
          Colors.black.withOpacity(0.6),
          BlendMode.darken,
        ),
        image: NetworkImage(
          imgsrc,
        ),
        fit: BoxFit.cover,
      ),
    );
  }
}

class DesignOnBoarding extends StatelessWidget {
  const DesignOnBoarding({
    Key? key,
    required this.widget,
  }) : super(key: key);
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          widget,
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}

class TemplateButton extends StatelessWidget {
  const TemplateButton({
    Key? key,
    required this.size,
    required this.child,
    required this.width,
    required this.height,
    required this.borderRadius,
  }) : super(key: key);

  final Size size;
  final Widget child;
  final double width;
  final double height;
  final BorderRadiusGeometry borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color.fromARGB(255, 255, 102, 0), Colors.orange],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}

class OnboardingGetStartedButton extends StatelessWidget {
  final VoidCallback function;
  const OnboardingGetStartedButton({
    Key? key,
    required this.function,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          primary: Colors.transparent),
      onPressed: function,
      child: const Text(
        "Get Started",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class OnboardingText extends StatelessWidget {
  const OnboardingText({
    Key? key,
    required this.thinText,
    required this.boldText,
  }) : super(key: key);

  final String thinText;
  final String boldText;

  @override
  Widget build(BuildContext context) {
    return DelayedDisplay(
      delay: const Duration(seconds: 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            thinText,
            style: GoogleFonts.nunito(
              fontSize: 50,
              fontWeight: FontWeight.w200,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          Text(
            boldText,
            style: GoogleFonts.nunito(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Colors.white.withOpacity(0.8),
            ),
          )
        ],
      ),
    );
  }
}
