import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:real_estate/utils/c_extensions.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        // gradient: LinearGradient(
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        //   colors: <Color>[Colors.deepOrange, Colors.deepOrangeAccent],
        // ),
      ),
      child: SafeArea(
        child: IntroductionScreen(
          pages: [
            PageViewModel(
              title: 'Sell a home',
              body:
                  'Whether you choose traditional listing or explore innovative selling methods, we\'re here to guide you towards a successful home sale.',
              image: buildImage('sale'.png),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Buy a home',
              body:
                  'Discover your perfect home with us, where comfort meets your vision of a dream property.',
              image: buildImage('buy'.png),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Rent a home',
              body:
                  'Discover your next home to rent, where convenience and comfort await.',
              image: buildImage('rent'.png),
              decoration: getPageDecoration(),
            ),
            // PageViewModel(
            //   title: 'Secure Chat',
            //   body:
            //       'Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups.',
            //   image: buildImage('assets/animations/security.json'),
            //   decoration: getPageDecoration(),
            // ),
            // PageViewModel(
            //   title: 'Music',
            //   body:
            //       'Music touches us emotionally, where words alone can’t. Listen to your favourite songs in just a tap.',
            //   image: buildImage('assets/animations/music.json'),
            //   decoration: getPageDecoration(),
            // ),
            // PageViewModel(
            //   title: 'News',
            //   body: 'Find the top news around you in simple terms.',
            //   image: buildImage('assets/animations/news.json'),
            //   decoration: getPageDecoration(),
            // ),
            // PageViewModel(
            //   title: 'Chat bot',
            //   body:
            //       'Keep in touch, manage tasks and to-dos, get answers, control your phone.',
            //   image: buildImage('assets/animations/robot-bot-3d.json'),
            //   decoration: getPageDecoration(),
            // ),
          ],
          done: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Padding(
              padding: EdgeInsets.all(14.0),
              child: Text(
                "Next",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          onDone: () => goToPhoneNumberScreen(context),
          showSkipButton: true,
          skip: const Text('Skip'),
          onSkip: () => goToPhoneNumberScreen(context),
          skipStyle: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(
            Colors.black,
          )),
          next: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Padding(
              padding: EdgeInsets.all(14.0),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.white,
              ),
            ),
          ),
          dotsDecorator: getDotDecoration(),
          globalBackgroundColor: Colors.transparent,
        ),
      ),
    );
  }

  void goToPhoneNumberScreen(context) {
    // Get.to(
    //       () => const PhoneNumberAndOtp(),
    //   transition: Transition.fadeIn,
    // );
  }

  Widget buildImage(String path) {
    return Center(
      child: Image.asset(
        path,
        width: double.infinity,
      ),
    );
  }

  DotsDecorator getDotDecoration() => DotsDecorator(
        color: Colors.black87,
        activeColor: Colors.black,
        size: const Size(10, 10),
        activeSize: const Size(22, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      );

  PageDecoration getPageDecoration() => PageDecoration(
        titleTextStyle: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        bodyTextStyle: const TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
        footerPadding: const EdgeInsets.all(16).copyWith(bottom: 0),
        imagePadding: const EdgeInsets.all(24),
      );
}
