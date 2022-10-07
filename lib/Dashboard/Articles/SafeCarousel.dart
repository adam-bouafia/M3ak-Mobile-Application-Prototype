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
                                  title: "Déclaration de l'IFE-EFI sur l'explosion de Beyrouth",
                                  url: "https://www.efi-ife.org/fr/d%c3%a9claration-de-life-efi-sur-lexplosion-de-beyrouth"));
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
                                  title: "19 juin - Journée internationale pour l'élimination de la violence sexuelle en temps de conflit",
                                  url: "https://efi-ife.org/fr/19-juin-journ%C3%A9e-internationale-pour-l%C3%A9limination-de-la-violence-sexuelle-en-temps-de-conflit"));
                        }  else {
                          navigateToRoute(
                              context,
                              SafeWebView(
                                  index: index,
                                  title: "La Révocation du Droit à L’avortement aux Etats-Unis est une Régression Majeure pour les Droits des Femmes",
                                  url: "https://efi-ife.org/fr/la-r%C3%A9vocation-du-droit-%C3%A0-l%E2%80%99avortement-aux-etats-unis-est-une-r%C3%A9gression-majeure-pour-les-droits-des"));
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
                                style: TextStyle(fontFamily: 'metaplusmedium',
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
