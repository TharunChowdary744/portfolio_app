import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:portfolio/src/features/experiences/presentation/experiences_screen.dart';
import 'package:portfolio/src/features/projects/presentation/projects_screen.dart';
import 'package:portfolio/src/features/settings/presentation/settings_screen.dart';
import 'package:portfolio/src/features/tech/presentation/techs_screen.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    ExperiencesScreen(),
    TechsScreen(),
    ProjectsScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: CustomNavigationBar(
        backgroundColor: Theme.of(context).dividerColor,
        // onTap: onDestinationSelected,
        // currentIndex: currentIndex,
        isFloating: true,
        borderRadius: Radius.circular(26),
        iconSize: 52.0,
        // selectedColor: Color(0xff040267),
        selectedColor: Theme.of(context).primaryColor,
        strokeColor: Theme.of(context).scaffoldBackgroundColor,

        unSelectedColor: Theme.of(context).dividerColor,
        elevation: 10,
        scaleFactor: 0.22,

        scaleCurve: Curves.easeInOutCubicEmphasized,
        items: [
          CustomNavigationBarItem(
            icon: Center(
              child: SvgPicture.asset(
                "assets/icons/menu/career-choice.svg",
                height: 26,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
            selectedIcon: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(26),
              ),
              child: Center(
                child: SvgPicture.asset(
                  "assets/icons/menu/career-choice-filled.svg",
                  height: 26,
                  color: Theme.of(context).dividerColor,
                ),
              ),
            ),
          ),
          CustomNavigationBarItem(
            icon: Center(
              child: SvgPicture.asset(
                "assets/icons/menu/coding.svg",
                height: 26,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
            selectedIcon: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(26),
              ),
              child: Center(
                child: SvgPicture.asset(
                  "assets/icons/menu/coding-filled.svg",
                  height: 26,
                  color: Theme.of(context).dividerColor,
                ),
              ),
            ),
          ),
          CustomNavigationBarItem(
            icon: Center(
              child: SvgPicture.asset(
                "assets/icons/menu/start-up.svg",
                height: 24,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
            selectedIcon: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(26),
              ),
              child: Center(
                child: SvgPicture.asset(
                  "assets/icons/menu/start-up-filled.svg",
                  height: 24,
                  color: Theme.of(context).dividerColor,
                ),
              ),
            ),
          ),
          CustomNavigationBarItem(
            icon: Center(
              child: SvgPicture.asset(
                "assets/icons/menu/settings.svg",
                height: 24,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
            selectedIcon: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(26),
              ),
              child: Center(
                child: SvgPicture.asset(
                  "assets/icons/menu/settings-filled.svg",
                  height: 24,
                  color: Theme.of(context).dividerColor,
                ),
              ),
            ),
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
