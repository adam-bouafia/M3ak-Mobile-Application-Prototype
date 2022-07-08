import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class Smsaccess extends StatelessWidget {
  final AnimationController animationController;

  const Smsaccess({Key key, this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _firstHalfAnimation11 =
        Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.4,
        0.6,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final _secondHalfAnimation11 =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(-1, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.6,
        0.8,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    final _moodFirstHalfAnimation =
        Tween<Offset>(begin: Offset(2, 0), end: Offset(0, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.4,
        0.6,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final _moodSecondHalfAnimation11 =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(-2, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.6,
        0.8,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final _imageFirstHalfAnimation11 =
        Tween<Offset>(begin: Offset(4, 0), end: Offset(0, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.4,
        0.6,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final _imageSecondHalfAnimation11 =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(-4, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.6,
        0.8,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    return SlideTransition(
      position: _firstHalfAnimation11,
      child: SlideTransition(
        position: _secondHalfAnimation11,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "M3ak app needs your permission to get access to SMS and PhoneCall for it to function security Safe modes.",
                style: TextStyle(color: Color(0xff132137), fontSize: 16,),
                textAlign: TextAlign.center,
              ),
              SlideTransition(
                position: _moodFirstHalfAnimation,
                child: SlideTransition(
                  position: _moodSecondHalfAnimation11,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 64, right: 64, top: 16, bottom: 16),
                    child: ElevatedButton(
                        onPressed:checkpermission_smsphone,
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xff132137),
                          onPrimary: Colors.white,
                          shadowColor: Color(0xff132137),
                          elevation: 3,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
                          minimumSize: Size(100, 40),
                        ),
                        child: Text('Grant SMS and Phone Access',
                          style: TextStyle(
                            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500,),
                            textAlign: TextAlign.center,
                        )
                    ),
                  ),
                  ),
                ),
              SlideTransition(
                position: _imageFirstHalfAnimation11,
                child: SlideTransition(
                  position: _imageSecondHalfAnimation11,
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 550, maxHeight: 450),
                    child: Image.asset(
                      'assets/onboarding/mood_dairy_image.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void checkpermission_smsphone() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.sms,
      Permission.phone,
    ].request();
    print("sms permission: ${statuses[Permission.sms]}, "
        "phone permission: ${statuses[Permission.phone]}");
  }
}
