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
                                          title: "Déclaration de l'IFE-EFI sur l'explosion de Beyrouth",
                                          url: "https://www.efi-ife.org/fr/d%c3%a9claration-de-life-efi-sur-lexplosion-de-beyrouth"));
                                } else if (index == 1) {
                                  navigateToRoute(
                                      context,
                                      SafeWebView(
                                          index: index,
                                          title: "Communiqué de presse - Dialogue politique régional en ligne :Combattre les violences faites aux femmes et aux filles et renforcer les droits des femmes dans le contexte de la pandémie de Covid-19",
                                          url: "https://www.efi-ife.org/fr/communiqu%c3%a9-de-presse-dialogue-politique-r%c3%a9gional-en-ligne-combattre-les-violences-faites-aux-femmes"));
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
                                } else {
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
                                      padding: const EdgeInsets.only(
                                          left: 8.0, bottom: 8),
                                      child: Text(
                                        articleTitle[index],
                                        style: TextStyle(fontFamily: 'metaplusmedium',
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
