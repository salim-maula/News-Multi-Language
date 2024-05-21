import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kolink_news/common/widget/popups/dialog_loader.dart';
import 'package:kolink_news/view/home/controller/home_controller.dart';
import 'package:kolink_news/view/home/screen/business_news.dart';
import 'package:kolink_news/view/home/screen/entertainment_news.dart';
import 'package:kolink_news/view/home/screen/health_news.dart';
import 'package:kolink_news/view/home/screen/science_news.dart';
import 'package:kolink_news/view/home/screen/sport_news.dart';
import 'package:kolink_news/view/home/screen/trending_news.dart';
import 'package:kolink_news/view/home/screen/technology_news.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final controller = Get.put(HomeController());
  final Map<int, bool> _loadedTabs = {};
  late TabController tabController;

  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    controller.getNewsTrending("trending");
    _loadedTabs[0] = true;
    print(controller.storage.read("CODELANGUAGE")+" : CODELANGUAGE");
    print(controller.storage.read("LANGUAGE")+" : LANGUAGE");
    print(controller.storage.read("CODECOUNTRY")+" : CODECOUNTRY");
    print(controller.storage.read("COUNTRY")+" : COUNTRY");

    // controller.getNews("business", 2);
    // _loadedTabs[1] = true;

    // controller.getNews("entertainment", 3);
    // _loadedTabs[2] = true;

    // controller.getNews("sports", 4);
    // _loadedTabs[3] = true;

    // controller.getNews("technology", 5);
    // _loadedTabs[4] = true;

    // controller.getNews("science", 6);
    // _loadedTabs[5] = true;

    // controller.getNews("health", 7);
    // _loadedTabs[6] = true;

    tabController = TabController(length: 7, vsync: this);
    tabController.addListener(_handleSwipeTabSelection);
  }

  void _handleSwipeTabSelection() {
    // Mendapatkan indeks tab yang sedang aktif
    int currentIndex = tabController.index;

    // Panggil fungsi _handleTabSelection untuk tab yang sedang aktif
    _handleTabSelection(currentIndex);
  }

  void _handleTabSelection(int index) {
    if (_loadedTabs[index] == null || !_loadedTabs[index]!) {
      switch (index) {
        case 0:
          controller.getNewsTrending("top");
          _loadedTabs[0] = true;
          break;
        case 1:
          controller.getNewsBusiness("business");
          _loadedTabs[1] = true;
          break;
        case 2:
          controller.getNews("entertainment", 3);
          _loadedTabs[2] = true;
          break;
        case 3:
          controller.getNews("sports", 4);
          _loadedTabs[3] = true;
          break;
        case 4:
          controller.getNews("technology", 5);
          _loadedTabs[4] = true;
          break;
        case 5:
          controller.getNews("science", 6);
          _loadedTabs[5] = true;
          break;
        case 6:
          controller.getNews("health", 7);
          _loadedTabs[6] = true;
          break;
        default:
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget bagianTabBar = TabBar(
        controller: tabController,
        labelColor: Colors.white,
        dividerHeight: 0,
        splashFactory: NoSplash.splashFactory,
        splashBorderRadius: BorderRadius.circular(50),
        tabAlignment: TabAlignment.start,
        isScrollable: true,
        unselectedLabelColor: Colors.blue,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(50), color: Colors.blue),
        onTap: _handleTabSelection,
        tabs: <Widget>[
          Tab(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                //border: Border.all(color: Colors.blue)
              ),
              child: const Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(left: 12, right: 12),
                  child: Text("Trending"),
                ),
              ),
            ),
          ),
          Tab(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                //border: Border.all(color: Colors.blue)
              ),
              child: const Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(left: 12, right: 12),
                  child: Text("Business"),
                ),
              ),
            ),
          ),
          Tab(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                //border: Border.all(color: Colors.blue)
              ),
              child: const Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(left: 12, right: 12),
                  child: Text("Entertainment"),
                ),
              ),
            ),
          ),
          Tab(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                //border: Border.all(color: Colors.blue)
              ),
              child: const Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(left: 12, right: 12),
                  child: Text("Sport"),
                ),
              ),
            ),
          ),
          Tab(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                //border: Border.all(color: Colors.blue)
              ),
              child: const Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(left: 12, right: 12),
                  child: Text("Technology"),
                ),
              ),
            ),
          ),
          Tab(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                //border: Border.all(color: Colors.blue)
              ),
              child: const Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(left: 12, right: 12),
                  child: Text("Science"),
                ),
              ),
            ),
          ),
          Tab(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                //border: Border.all(color: Colors.blue)
              ),
              child: const Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(left: 12, right: 12),
                  child: Text("Health"),
                ),
              ),
            ),
          ),
        ]);

    return DefaultTabController(
        length: 7,
        child: Scaffold(
            appBar: AppBar(
              title: const Text.rich(
                  TextSpan(text: 'Kolink ', children: <InlineSpan>[
                TextSpan(
                  text: 'News',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                )
              ])),
              // Text(
              //   'Kolink News',
              //   style: TextStyle(
              //       fontWeight: FontWeight.bold, color: Colors.blue[700]),
              // ),
              backgroundColor: Colors.white,
              iconTheme: const IconThemeData(color: Colors.black),
              elevation: 0,
              bottom: PreferredSize(
                preferredSize: const Size(200.0, 52),
                child: Container(
                    margin: const EdgeInsets.only(left: 8, right: 16),
                    child: bagianTabBar),
              ),
              actions: <Widget>[
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Iconsax.notification),
                ),
                // Container(
                //   margin: const EdgeInsets.only(right: 0),
                //   child: IconButton(
                //       onPressed: () {},
                //       icon: Image.asset('assets/images/icon_user.png')),
                // )
              ],
            ),
            backgroundColor: Colors.white,
            // drawer: DrawerMenu(),
            body: TabBarView(
              controller: tabController,
              children: <Widget>[
                TrendingNews(),
                BusinessNews(),
                EntertainmentNews(),
                SportNews(),
                TechnologyNews(),
                ScienceNews(),
                HealthNews(),
              ],
            )));
  }
}
