import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class Locationaccess extends StatelessWidget {
  final AnimationController animationController;

  const Locationaccess({Key key, this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _firstHalfAnimation1 =
    Tween<Offset>(begin: Offset(0, 1), end: Offset(0, 0))
        .animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.0,
        0.2,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final _secondHalfAnimation1 =
    Tween<Offset>(begin: Offset(0, 0), end: Offset(-1, 0))
        .animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.2,
        0.4,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final _relaxFirstHalfAnimation1 =
    Tween<Offset>(begin: Offset(0, 0), end: Offset(-2, 0))
        .animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.2,
        0.4,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final _relaxSecondHalfAnimation1 =
    Tween<Offset>(begin: Offset(0, 0), end: Offset(-4, 0))
        .animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.2,
        0.4,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    final _imageFirstHalfAnimation1 =
    Tween<Offset>(begin: Offset(4, 0), end: Offset(0, 0))
        .animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.2,
        0.4,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final _imageSecondHalfAnimation1 =
    Tween<Offset>(begin: Offset(0, 0), end: Offset(-4, 0))
        .animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.0,
        0.2,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    return SlideTransition(
      position: _firstHalfAnimation1,
      child: SlideTransition(
        position: _secondHalfAnimation1,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SlideTransition(
                position: _imageFirstHalfAnimation1,
                child: SlideTransition(
                  position: _imageSecondHalfAnimation1,
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 400, maxHeight: 300),
                    child: Image.asset(
                      'assets/onboarding/Clip.gif',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              SlideTransition(
                position: _relaxFirstHalfAnimation1,
                child: SlideTransition(
                  position: _relaxSecondHalfAnimation1,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 64, right: 64, top: 16, bottom: 16),
                    child: Text(
                      'onblocadesc'.tr,
                      style: TextStyle(fontFamily: 'Montserrat', fontSize: 16,),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 40, right: 40, top: 40, bottom: 60),
                child: ElevatedButton(
                    onPressed:checkpermission_location,
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xffd19974),
                      onPrimary: Colors.white,
                      shadowColor: Color(0xffd19974),
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                      minimumSize: Size(100, 40), //////// HERE
                    ),
                    child: Text('onblocauto'.tr,
                      style: TextStyle(fontFamily: 'Montserrat',
                        color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500,
                      ),
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void checkpermission_location() async {
    var status = await Permission.location.status;
    if (status.isDenied) {
      await Permission.location.request();
    }
  }
}