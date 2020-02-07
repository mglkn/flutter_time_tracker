import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../utils/app_localization.dart';
import '../../../store/home_store.dart';
import '../../../routes/router.gr.dart';
import 'widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController = PageController(
    keepPage: true,
    initialPage: 0,
  );

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _onBottomNavTapped({int index, HomeStore store}) {
    store.setPageIndex(index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  BottomNavigationBarItem _buildBottomNavBar({
    String title,
    IconData icon,
  }) {
    return BottomNavigationBarItem(
      icon: Icon(icon),
      title: Text(title),
    );
  }

  FloatingActionButton _buildFloatingActionButton() {
    final HomeStore store = Provider.of<HomeStore>(context, listen: false);
    return FloatingActionButton(
      child: Icon(Icons.add),
      elevation: 1.0,
      onPressed: () async {
        if (store.pageIndex == 0) {
          await AppRouter.navigator
              .pushNamed(AppRouter.goalFormScreen, arguments: null);
          store.setGoalStatus(EGoalStatus.ONGOING);
          return;
        }
        AppRouter.navigator.pushNamed(AppRouter.tagFormScreen, arguments: null);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final done = AppLocalizations.of(context).translate('done').toUpperCase();
    final ongoing =
        AppLocalizations.of(context).translate('ongoing').toUpperCase();

    return Consumer(
      builder: (_, HomeStore store, __) => Scaffold(
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
      ),
    );
  }

  AppBar _buildAppBar(HomeStore store) {
    final String titleGoals =
        AppLocalizations.of(context).translate("goals").toUpperCase();
    final String titleTags =
        AppLocalizations.of(context).translate("tags").toUpperCase();

    return AppBar(
      title: Observer(
        builder: (_) => AppBarTitle(
          store.pageIndex == 0 ? titleGoals : titleTags,
        ),
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

    return Observer(
      builder: (_) => BottomNavigationBar(
        backgroundColor: Theme.of(context).backgroundColor,
        currentIndex: store.pageIndex,
        onTap: (index) => _onBottomNavTapped(
          index: index,
          store: store,
        ),
        elevation: 4.0,
        iconSize: 26.0,
        items: [
          _buildBottomNavBar(title: titleGoals, icon: Icons.gps_fixed),
          _buildBottomNavBar(title: titleTags, icon: Icons.local_offer),
        ],
      ),
    );
  }
}
