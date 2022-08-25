import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Dhayen/Dashboard/Articles/ArticleDesc.dart';
import 'package:Dhayen/Dashboard/Articles/SadeWebView.dart';
import 'package:Dhayen/Utility/constants.dart';

class SafeCarousel extends StatelessWidget {
  const SafeCarousel({Key key}) : super(key: key);

  void navigateToRoute(
    BuildContext context,
    Widget route,
  ) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => route,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          aspectRatio: 2.0,
          enlargeCenterPage: true,
        ),
        items: List.generate(
            imageSliders.length,
            (index) => Hero(
                  tag: articleTitle[index],
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: InkWell(
                      onTap: () {
                        if (index == 0) {
                          navigateToRoute(
                              context,
                              SafeWebView(
                                  index: index,
                                  title: "Militantes, étudiantes, activistes… Ces femmes qui se sont battues pour l’Algérie",
                                  url: "https://www.middleeasteye.net/fr/actu-et-enquetes/algerie-militantes-etudiantes-activistes-femmes-revolution-combat"));
                        } else if (index == 1) {
                          navigateToRoute(
                              context,
                              SafeWebView(
                                  index: index,
                                  title: "Combattre les violences faites aux femmes en Algérie : mobilisations et défis",
                                  url: "https://www.awid.org/fr/nouvelles-et-analyse/combattre-les-violences-faites-aux-femmes-en-algerie-mobilisations-et-defis"));
                        } else if (index == 2) {
                          navigateToRoute(
                              context, ArticleDesc(index: index));
                        } else if (index == 3) {
                          navigateToRoute(
                              context,
                              SafeWebView(
                                  index: index,
                                  title: "La guerre d’Algérie racontée par les femmes",
                                  url: "https://www.ina.fr/actualites-ina/la-guerre-d-algerie-racontee-par-les-femmes"));
                        }  else {
                          navigateToRoute(
                              context,
                              SafeWebView(
                                  index: index,
                                  title: "Algérie - Droits des femmes : « les violences les plus fréquentes sont familiales et conjugales »",
                                  url: "lepoint.fr/afrique/algerie-droits-des-femmes-les-violences-les-plus-frequentes-sont-familiales-et-conjugales-09-03-2018-2201165_3826.php"));
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: NetworkImage(imageSliders[index]),
                              fit: BoxFit.cover),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                  colors: [
                                    Colors.black.withOpacity(0.5),
                                    Colors.transparent
                                  ],
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight)),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, bottom: 8),
                              child: Text(
                                articleTitle[index],
                                style: TextStyle(fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.05,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
      ),
    );
  }
}
