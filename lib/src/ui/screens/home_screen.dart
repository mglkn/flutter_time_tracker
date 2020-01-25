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
  int _bottomSelectedIndex = 0;

  PageController _pageController = PageController(
    keepPage: true,
    initialPage: 0,
  );

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _pageChanged(int index) {
    setState(() {
      _bottomSelectedIndex = index;
    });
  }

  _onBottomNavTapped(int index) {
    _bottomSelectedIndex = index;
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
    return FloatingActionButton(
      child: Icon(Icons.add),
      elevation: 1.0,
      onPressed: () {
        if (_bottomSelectedIndex == 0) {
          AppRouter.navigator.pushNamed(AppRouter.goalFormScreen);
          return;
        }
        AppRouter.navigator.pushNamed(AppRouter.tagFormScreen);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final String titleGoals =
        AppLocalizations.of(context).translate("goals").toUpperCase();
    final String titleTags =
        AppLocalizations.of(context).translate("tags").toUpperCase();

    final checkedIcon = Icon(Icons.check_box);
    final uncheckedIcon = Icon(Icons.check_box_outline_blank);

    return Consumer(
      builder: (_, HomeStore store, __) => Scaffold(
        appBar: AppBar(
          title:
              AppBarTitle(_bottomSelectedIndex == 0 ? titleGoals : titleTags),
          actions: <Widget>[
            IconButton(
              icon: Observer(
                builder: (_) =>
                    store.isGoalDoneFlag ? uncheckedIcon : checkedIcon,
              ),
              onPressed: () => store.toggleGoalDoneFlag(),
            ),
          ],
          centerTitle: true,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _bottomSelectedIndex,
          onTap: _onBottomNavTapped,
          elevation: 4.0,
          items: [
            _buildBottomNavBar(title: titleGoals, icon: Icons.gps_fixed),
            _buildBottomNavBar(title: titleTags, icon: Icons.local_offer),
          ],
        ),
        floatingActionButton: _buildFloatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: SafeArea(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) => _pageChanged(index),
            children: <Widget>[
              GoalsView(),
              TagsView(),
            ],
          ),
        ),
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
