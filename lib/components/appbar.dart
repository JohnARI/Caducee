import 'package:caducee/common/const.dart';
import 'package:caducee/screens/home/drugs/category_list.dart';
import 'package:caducee/screens/home/drugs/favorite_drug.dart';
import 'package:caducee/services/database.dart';
import 'package:flutter/material.dart';
import 'package:caducee/screens/home/drugs/drug_list.dart';

class MyAppBar extends StatefulWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);

    // DatabaseService(uid: '').saveDrug(
    //   /* uid */
    //   "exacyl",
    //   /* name */
    //   "Exacyl",
    //   /* molecule */
    //   "Acide tranexamique",
    //   /* description */
    //   "L'Exacyl est un médicament antifibrinolytique utilisé pour traiter les saignements excessifs lors de menstruations abondantes ou de saignements utérins anormaux. Il agit en réduisant la dégradation des caillots de sang, ce qui permet de limiter les saignements. Il est également utilisé pour prévenir les saignements liés à certaines interventions chirurgicales, comme les extractions dentaires ou les opérations de la prostate. Il peut être utilisé chez les adultes et les enfants.",
    //   /* form */
    //   ["Comprimés", "Solution injectable", "Solution buvable"],
    //   /* dosage */
    //   ["Adulte: 1 à 2 comprimés par jour ou de 1 à 2 injections par jour.", "Enfant(-50kg): La dose est calculée en fonction du poids de l'enfant, consultez votre médecin."],
    //   /* category */
    //   "Antifibrinolytique",
    //   /* recommendation */
    //   "2 fois par jour, en respectant un intervalle de 12 heures entre chaque prise.",
    //   /* usage */
    //   "L'Exacyl est utilisé pour traiter les saignements excessifs lors de menstruations abondantes ou de saignements utérins anormaux, ainsi que pour prévenir les saignements liés à certaines interventions chirurgicales. Il peut également être utilisé pour traiter les saignements liés à des troubles tels que l'hémophilie ou les troubles de la coagulation.",
    //   /* favorite */
    //   [],

    // );

return Scaffold(
      backgroundColor: myTransparent,
      key: _scaffoldKey,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SafeArea(
            child: Container(
                padding: const EdgeInsets.only(left: 20.0, top: 20.0),
                height: 70,
                child: Image.asset('assets/images/textLogo.png')),
          ),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: TabBar(
                controller: tabController,
                isScrollable: true,
                labelPadding: const EdgeInsets.only(left: 20.0, right: 20.0),
                labelColor: Theme.of(context).textTheme.bodyText1!.color,
                unselectedLabelColor: Theme.of(context).textTheme.bodyText2!.color,
                indicator:
                    const CircleTabIndicator(color: myDarkGreen, radius: 3),
                unselectedLabelStyle: const TextStyle(fontSize: 16),
                labelStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                tabs: const [
                  InkWell(
                    child: Tab(
                      text: 'Médicaments',
                    ),
                  ),
                  Tab(
                    text: 'Catégories',
                  ),
                  Tab(
                    text: 'Favoris',
                  ),
                ]),
          ),
          Expanded(
            flex: 3,
              child: TabBarView(
                controller: tabController,
                children: const [
                  DrugList(),
                  CategoryList(),
                  FavoriteList(),
                ],
              ),
          ),
        ],
      ),
    );

  }
}

class CircleTabIndicator extends Decoration {
  final Color color;
  final double radius;

  const CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final double radius;
  late Color color;
  _CirclePainter({required this.color, required this.radius});
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    late Paint paint;
    paint = Paint()..color = color;
    paint = paint..isAntiAlias = true;
    final Offset circleOffset =
        offset + Offset(cfg.size!.width / 2, cfg.size!.height - radius);
    canvas.drawCircle(circleOffset, radius, paint);
  }
}
