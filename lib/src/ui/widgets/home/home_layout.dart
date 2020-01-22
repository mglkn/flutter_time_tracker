import 'package:flutter/material.dart';

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

class GoalsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Goals page'),
      ),
    );
  }
}

class TagsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Tags page'),
      ),
    );
  }
}
