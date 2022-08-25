import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Letsbegin extends StatefulWidget {
  final AnimationController animationController;

  const Letsbegin({Key key, this.animationController})
      : super(key: key);

  @override
  _LetsbeginState createState() => _LetsbeginState();

}

class _LetsbeginState extends State<Letsbegin> {
  final List locale =[
    {'name':'Arabic','locale': Locale('ar','AR')},
    {'name':'Français','locale': Locale('fr','FR')},
    {'name':'English','locale': Locale('en','US')},
    {'name':'Russian','locale': Locale('ru','RU')},
    {'name':'Italien','locale': Locale('it','IT')},
    {'name':'Deutsch','locale': Locale('de','DE')},
  ];
  updateLanguage(Locale locale){
    Get.back();
    Get.updateLocale(locale);
  }

  buildLanguageDialog(BuildContext context){
    showDialog(context: context,
        builder: (builder){
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            title: Text('choislang'.tr,
                style: TextStyle(fontFamily: 'Montserrat',fontSize: 22,)),
            backgroundColor: Color(0xfff5ebe2),
            contentPadding: EdgeInsets.only(top: 16.0, bottom: 16.0,left: 16.0,right: 16.0),
            content: Container(
              width: double.maxFinite,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(child: Text(locale[index]['name']),onTap: (){
                        print(locale[index]['name']);
                        updateLanguage(locale[index]['locale']);
                      },),
                    );
                  }, separatorBuilder: (context,index){
                return Divider(
                  color: Color(0xff000000),
                );
              }, itemCount: locale.length
              ),
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    final _introductionanimation =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(0.0, -1.0))
            .animate(CurvedAnimation(
      parent: widget.animationController,
      curve: Interval(
        0.0,
        0.2,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    return SlideTransition(
      position: _introductionanimation,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/onboarding/introduction_image.gif',
                fit: BoxFit.fitHeight,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Text(
                "Dhayen",
                style: TextStyle(fontFamily: 'Montserrat',fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(),
              child: Text(
                'onbletbegdesc'.tr,
                style: TextStyle(fontFamily: 'Montserrat',fontSize: 16,),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 48,
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom + 10),
              child: InkWell(
                onTap: () {
                  widget.animationController.animateTo(0.2);
                },
                child: Container(
                  height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          primary: Colors.kPrimaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))
                      ),
                      onPressed: (){
                      buildLanguageDialog(context);
                    },
                    child: Text(
                      'changelang'.tr,
                      style: TextStyle(fontFamily: 'Montserrat',
                        fontSize: 16,
                        color: Colors.white,
                       ),
                      ),
                    ),
                ),
              ),
            ),

            SizedBox(
              height: 55,
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom + 16),
              child: InkWell(
                onTap: () {
                  widget.animationController.animateTo(0.2);
                },
                child: Container(
                  height: 50,
                  padding: EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                    top: 15.0,
                    bottom: 15.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(38.0),
                    color: Color(0xffd19974),
                  ),
                  child: Text(
                    'onbletbegwelc'.tr,
                    style: TextStyle(fontFamily: 'Montserrat',
                      fontSize: 20,
                      color: Colors.white,
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
