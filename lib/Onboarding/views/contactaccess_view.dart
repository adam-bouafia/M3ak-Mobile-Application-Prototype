import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactAccess extends StatelessWidget {
  final AnimationController animationController;

  const ContactAccess({Key key, this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _firstHalfAnimation =
        Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.2,
        0.4,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final _secondHalfAnimation =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(-1, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.4,
        0.6,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final _relaxFirstHalfAnimation =
        Tween<Offset>(begin: Offset(2, 0), end: Offset(0, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.2,
        0.4,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final _relaxSecondHalfAnimation =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(-2, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.4,
        0.6,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    final _imageFirstHalfAnimation =
        Tween<Offset>(begin: Offset(4, 0), end: Offset(0, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.2,
        0.4,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final _imageSecondHalfAnimation =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(-4, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.4,
        0.6,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    return SlideTransition(
      position: _firstHalfAnimation,
      child: SlideTransition(
        position: _secondHalfAnimation,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SlideTransition(
                position: _imageFirstHalfAnimation,
                child: SlideTransition(
                  position: _imageSecondHalfAnimation,
                  child: Container(
                    constraints: BoxConstraints(maxWidth: 600, maxHeight: 450),
                    child: Image.asset(
                      'assets/onboarding/care_image.gif',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              SlideTransition(
                position: _relaxFirstHalfAnimation,
                child: SlideTransition(
                  position: _relaxSecondHalfAnimation,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 64, right: 64, top: 16, bottom: 16),
                  child: Text(
                    'onbcontdesc'.tr,
                    style: TextStyle(fontFamily: 'Montserrat',color: Color(0xff132137), fontSize: 17,),
                    textAlign: TextAlign.center,
                  ),
                ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 40, right: 40, top: 50, bottom: 50),
                child: ElevatedButton(
                    onPressed:checkpermission_contacts,
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xffd19974),
                      onPrimary: Colors.white,
                      shadowColor: Color(0xffd19974),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                      minimumSize: Size(100, 40), //////// HERE
                    ),
                    child: Text('onbcontautor'.tr,
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
void checkpermission_contacts() async {
  var status = await Permission.contacts.status;
  if (status.isGranted) {
    print("Permission is granted");
  }
  else if (status.isDenied) {
    if (await Permission.contacts.request().isGranted) {
      print("Permission was granted");
    }
  }
}
}