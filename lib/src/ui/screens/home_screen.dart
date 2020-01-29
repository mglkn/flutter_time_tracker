import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker/src/routes/router.gr.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../utils/app_localization.dart';
import '../../ui/widgets/home/home.dart';
import '../../store/home_store.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => _HomeScreen();
}

class _HomeScreen extends StatefulWidget {
  @override
  __HomeScreenState createState() => __HomeScreenState();
}

class __HomeScreenState extends State<_HomeScreen> {
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
      onPressed: () {
        if (store.pageIndex == 0) {
          AppRouter.navigator
              .pushNamed(AppRouter.goalFormScreen, arguments: null);
          return;
        }
        AppRouter.navigator.pushNamed(AppRouter.tagFormScreen, arguments: null);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
              GoalsView(),
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

    final checkedIcon = Icon(Icons.check_box);
    final uncheckedIcon = Icon(Icons.check_box_outline_blank);

    return AppBar(
      title: Observer(
        builder: (_) => AppBarTitle(
          store.pageIndex == 0 ? titleGoals : titleTags,
        ),
      ),
      actions: <Widget>[
        Observer(
          builder: (_) => store.pageIndex == 0
              ? IconButton(
                  icon: Observer(
                    builder: (_) =>
                        store.isGoalDoneFlag ? uncheckedIcon : checkedIcon,
                  ),
                  onPressed: () => store.toggleGoalDoneFlag(),
                )
              : Container(),
        ),
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
        currentIndex: store.pageIndex,
        onTap: (index) => _onBottomNavTapped(
          index: index,
          store: store,
        ),
        elevation: 4.0,
        items: [
          _buildBottomNavBar(title: titleGoals, icon: Icons.gps_fixed),
          _buildBottomNavBar(title: titleTags, icon: Icons.local_offer),
        ],
      ),
    );
  }
}

class AppBarTitle extends StatelessWidget {
  final String title;

  AppBarTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(title);
  }
}
