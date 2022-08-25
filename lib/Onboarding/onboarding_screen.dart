import 'package:Dhayen/Onboarding/views/contactaccess_view.dart';
import 'package:Dhayen/Onboarding/views/letsbegin_view.dart';
import 'package:Dhayen/Onboarding/views/locationacess_view.dart';
import 'package:Dhayen/Onboarding/views/smsaccess_view.dart';
import 'package:Dhayen/onboarding/views/signuploginonboard.dart';
import 'package:Dhayen/onboarding/views/top_back_skip_view.dart';
import 'package:Dhayen/onboarding/views/welcome_view.dart';
import 'package:flutter/material.dart';
import '../login/screens/signup_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key key}) : super(key: key);

  @override
  _OnboardingScreenState createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState
    extends State<OnboardingScreen> with TickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 8));
    _animationController?.animateTo(0.0);
    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(_animationController?.value);
    return Scaffold(
      backgroundColor: Color(0xffF7EBE1),
      body: ClipRect(
        child: Stack(
          children: [
            WelcomeView(
              animationController: _animationController,
            ),
            ContactAccess(
              animationController: _animationController,
            ),
            Smsaccess(
              animationController: _animationController,
            ),
            Locationaccess(
              animationController: _animationController,
            ),
            Letsbegin(
              animationController: _animationController,
            ),
            TopBackSkipView(
              onBackClick: _onBackClick,
              onSkipClick: _onSkipClick,
              animationController: _animationController,
            ),
            CenterNextButton(
              animationController: _animationController,
              onNextClick: _onNextClick,
            ),
          ],
        ),
      ),
    );
  }

  void _onSkipClick() {
    _animationController?.animateTo(0.8,
        duration: Duration(milliseconds: 1200));
  }

  void _onBackClick() {
    if (_animationController.value >= 0 &&
        _animationController.value <= 0.2) {
      _animationController?.animateTo(0.0);
    } else if (_animationController.value > 0.2 &&
        _animationController.value <= 0.4) {
      _animationController?.animateTo(0.2);
    } else if (_animationController.value > 0.4 &&
        _animationController.value <= 0.6) {
      _animationController?.animateTo(0.4);
    } else if (_animationController.value > 0.6 &&
        _animationController.value <= 0.8) {
      _animationController?.animateTo(0.6);
    } else if (_animationController.value > 0.8 &&
        _animationController.value <= 1.0) {
      _animationController.animateTo(0.8);
    }
  }

  void _onNextClick() {
    if (_animationController.value >= 0 &&
        _animationController.value <= 0.2) {
      _animationController?.animateTo(0.4);
    } else if (_animationController.value > 0.2 &&
        _animationController.value <= 0.4) {
      _animationController?.animateTo(0.6);
    } else if (_animationController.value > 0.4 &&
        _animationController.value <= 0.6) {
      _animationController?.animateTo(0.8);
    } else if (_animationController.value > 0.6 &&
        _animationController.value <= 0.8) {
      _signUpClick();
    }
  }

  void _signUpClick() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => SignUpScreen()));
    }
  }