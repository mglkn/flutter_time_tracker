import 'package:flutter/material.dart';

import 'goals_page.dart';
import 'tags_page.dart';

class HomeLayout extends StatefulWidget {
  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
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
        print('add some');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final String titleGoals = 'Goals';
    final String titleTags = 'Tags';

    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(_bottomSelectedIndex == 0 ? titleGoals : titleTags),
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
            GoalsPage(),
            TagsPage(),
          ],
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