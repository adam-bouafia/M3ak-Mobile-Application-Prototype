import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:Dhayen/Dashboard/Articles/ArticleDesc.dart';
import 'package:Dhayen/Dashboard/Articles/SadeWebView.dart';
import 'package:Dhayen/Utility/constants.dart';

class AllArticles extends StatefulWidget {
  AllArticles({Key key}) : super(key: key);

  @override
  _AllArticlesState createState() => _AllArticlesState();
}

class _AllArticlesState extends State<AllArticles>
    with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
  }

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
    return Scaffold(
      body: SafeArea(
        child: Stack(fit: StackFit.expand, children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/bg-top.png',
                ),
                fit: BoxFit.fitWidth,
                alignment: Alignment.topCenter,
              ),
              color: Colors.grey[50].withOpacity(0.3),
            ),
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: 188.0,
                  backgroundColor: Colors.grey[50].withOpacity(0.3),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Lottie.asset(
                      "assets/reading.json",
                      controller: _controller,
                      onLoaded: (composition) {
                        _controller
                          ..duration = composition.duration
                          ..forward();
                      },
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    List.generate(
                      imageSliders.length,
                      (index) => Hero(
                        tag: articleTitle[index],
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Container(
                            height: 180,
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
                                          title: "Algérie - Droits des femmes : « les violences les plus fréquentes sont familiales et conjugales »",
                                          url: "https://www.lepoint.fr/afrique/algerie-droits-des-femmes-les-violences-les-plus-frequentes-sont-familiales-et-conjugales-09-03-2018-2201165_3826.php"));
                                } else if (index == 2) {
                                  navigateToRoute(
                                      context, ArticleDesc(index: index));
                                } else if (index == 3) {
                                  navigateToRoute(
                                      context,
                                      SafeWebView(
                                          index: index,
                                          title: "Combattre les violences faites aux femmes en Algérie : mobilisations et défis",
                                          url: "https://www.awid.org/fr/nouvelles-et-analyse/combattre-les-violences-faites-aux-femmes-en-algerie-mobilisations-et-defis"));
                                } else {
                                  navigateToRoute(
                                      context,
                                      SafeWebView(
                                          index: index,
                                          title: "La guerre d’Algérie racontée par les femmes",
                                          url: "https://www.ina.fr/actualites-ina/la-guerre-d-algerie-racontee-par-les-femmes"));
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
                                      padding: const EdgeInsets.only(
                                          left: 8.0, bottom: 8),
                                      child: Text(
                                        articleTitle[index],
                                        style: TextStyle(fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.bold,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.05,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
