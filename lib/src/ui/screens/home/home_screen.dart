import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../utils/app_localization.dart';
import '../../../store/home_store.dart';
import 'widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double pagePosition = 0.0;

  PageController _pageController = PageController(
    keepPage: true,
    initialPage: 0,
  );

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pageController
        .addListener(() => setState(() => pagePosition = _pageController.page));
  }

  _onBottomNavTapped({int index, HomeStore store}) {
    store.setPageIndex(index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  FloatingActionButton _buildFloatingActionButton() {
    final HomeStore store = Modular.get<HomeStore>();

    return FloatingActionButton(
      child: Icon(Icons.add),
      elevation: 1.0,
      onPressed: () async {
        if (store.pageIndex == 0) {
          await Modular.to.pushNamed('/goalForm', arguments: null);
          store.setGoalStatus(EGoalStatus.ONGOING);
          return;
        }
        await Modular.to.pushNamed('/tagForm', arguments: null);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final done = AppLocalizations.of(context).translate('done').toUpperCase();
    final ongoing =
        AppLocalizations.of(context).translate('ongoing').toUpperCase();
    final HomeStore store = Modular.get<HomeStore>();

    return Scaffold(
      appBar: _buildAppBar(store),
      bottomNavigationBar: _buildBottomNavigationBar(store),
      floatingActionButton: _buildFloatingActionButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) => store.setPageIndex(index),
          children: <Widget>[
            Column(
              children: <Widget>[
                Observer(
                  builder: (_) =>
                      store.isGoalDone ? Text('$done') : Text('$ongoing'),
                ),
                Expanded(child: GoalsView()),
              ],
            ),
            TagsView(),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(HomeStore store) {
    final String titleGoals =
        AppLocalizations.of(context).translate("goals").toUpperCase();
    final String titleTags =
        AppLocalizations.of(context).translate("tags").toUpperCase();

    return AppBar(
      title: AppBarTitle(
        titleGoals: titleGoals,
        titleTags: titleTags,
        pagePosition: pagePosition,
      ),
      actions: <Widget>[
        FilterPopupMenuButton(),
      ],
      centerTitle: true,
    );
  }

  Widget _buildBottomNavigationBar(HomeStore store) {
    final String titleGoals =
        AppLocalizations.of(context).translate("goals").toUpperCase();
    final String titleTags =
        AppLocalizations.of(context).translate("tags").toUpperCase();

    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      color: Theme.of(context).backgroundColor,
      elevation: 20.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          BottomAppBarItem(
            iconData: Icons.gps_fixed,
            title: titleGoals,
            selectCallback: _onBottomNavTapped,
            index: 0,
          ),
          BottomAppBarItem(
            iconData: Icons.local_offer,
            title: titleTags,
            selectCallback: _onBottomNavTapped,
            index: 1,
          ),
        ],
      ),
    );
  }
}
