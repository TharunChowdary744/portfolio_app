import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:portfolio/src/features/experiences/domain/entities/experience.dart';
import 'package:portfolio/src/features/experiences/presentation/experiences_screen.dart';
import 'package:portfolio/src/features/projects/domain/entities/project.dart';
import 'package:portfolio/src/features/projects/presentation/projects_screen.dart';
import 'package:portfolio/src/features/settings/domain/profile.dart';
import 'package:portfolio/src/features/settings/presentation/settings_screen.dart';
import 'package:portfolio/src/features/tech/presentation/techs_screen.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Profile> profile = [];
  List<Experience> experiences = [];
  List<Project> projects = [];

  late List<Widget> _pages;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchAllData();
  }

  Future<void> getProfileById(String profileId) async {
    try {
      CollectionReference profiles = FirebaseFirestore.instance.collection('profiles');
      QuerySnapshot querySnapshot = await profiles.where('profileId', isEqualTo: profileId).get();

      if (querySnapshot.docs.isNotEmpty) {
        List<Profile> fetchedProfiles = querySnapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return Profile.fromMap(data);
        }).toList();

        setState(() {
          profile = fetchedProfiles;
        });
      } else {
        setState(() {
          profile = [];
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future<void> getExperienceByProfileId(String profileId) async {
    try {
      CollectionReference experiencesRef = FirebaseFirestore.instance.collection('experiences');
      QuerySnapshot querySnapshot = await experiencesRef.where('profileId', isEqualTo: profileId).get();

      if (querySnapshot.docs.isNotEmpty) {
        List<Experience> fetchedExperiences = querySnapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return Experience(
            id: doc.id,
            title: data['title'],
            description: data['description'],
            startYear: data['startYear'],
            endYear: data['endYear'],
            logoUrl: data['logoUrl'],
            city: data['city'],
            country: data['country'],
            company: data['company'],
            salary: data['salary'],
            time: data['time'],
            workType: data['workType'],
            technologies: List<Map<String, dynamic>>.from(data['technologies'] ?? []),
          );
        }).toList();

        setState(() {
          experiences = fetchedExperiences;
        });
      } else {
        setState(() {
          experiences = [];
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  // Future<void> getProjectsByProfileId(String profileId) async {
  //   try {
  //     CollectionReference projectsRef = FirebaseFirestore.instance.collection('projects');
  //     QuerySnapshot querySnapshot = await projectsRef.where('profileId', isEqualTo: profileId).get();
  //
  //     if (querySnapshot.docs.isNotEmpty) {
  //       List<Project> fetchedProjects = querySnapshot.docs.map((doc) {
  //         final data = doc.data() as Map<String, dynamic>;
  //         return Project(
  //           id: doc.id,
  //           description: data['description'],
  //           workType: data['workType'],
  //           name: data['name'],
  //           color: Colors.red,
  //           categories: data['categories'],
  //           features: data['features'],
  //           assetImages: data['images'],
  //         );
  //       }).toList();
  //
  //       setState(() {
  //         projects = fetchedProjects;
  //       });
  //     } else {
  //       setState(() {
  //         projects = [];
  //       });
  //     }
  //   } catch (e) {
  //     print('Error fetching getProjectsByProfileId data: $e');
  //   }
  // }
  Future<void> getProjectsByProfileId(String profileId) async {
    try {
      CollectionReference projectsRef = FirebaseFirestore.instance.collection('projects');
      QuerySnapshot querySnapshot = await projectsRef.where('profileId', isEqualTo: profileId).get();

      if (querySnapshot.docs.isNotEmpty) {
        List<Project> fetchedProjects = querySnapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;

          // Convert categories and features from dynamic to the specific types
          List<ProjectCategory> categories =
              (data['categories'] as List<dynamic>).map((category) => ProjectCategory.fromMap(category as Map<String, dynamic>)).toList();
          List<ProjectFeatures> features =
              (data['features'] as List<dynamic>).map((feature) => ProjectFeatures.fromMap(feature as Map<String, dynamic>)).toList();

          Color color = Colors.red; // Default value, adjust as needed
          if (data['color'] != null) {
            // Assuming color is stored as a hex string in Firestore, adjust parsing as needed
            try {
              color = Color(int.parse(data['color'].replaceFirst('#', '0xff')));
            } catch (e) {
              print('Error parsing color: $e');
            }
          }

          return Project(
            id: data['projectId'],
            description: data['description'],
            workType: data['workType'],
            name: data['name'],
            color: color,
            categories: categories,
            features: features,
            images: List<String>.from(data['images'] ?? []),
          );
        }).toList();

        setState(() {
          projects = fetchedProjects;
        });
      } else {
        setState(() {
          projects = [];
        });
      }
    } catch (e) {
      print('Error fetching getProjectsByProfileId data: $e');
    }
  }

  Future<void> fetchAllData() async {
    String profileId = 'UQiyhgjnAYTtZw94iime';
    setState(() {
      _isLoading = true;
    });

    await getProfileById(profileId);
    await getExperienceByProfileId(profileId);
    await getProjectsByProfileId(profileId);

    setState(() {
      _pages = [
        ExperiencesScreen(experiences: experiences),
        TechsScreen(skillSet: profile.isNotEmpty ? profile[0].skillSet : []),
        ProjectsScreen(projects: projects,projectCategories: profile.isNotEmpty ? profile[0].projectCategories : []),
        SettingsScreen(),
      ];
      _isLoading = false;
    });
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading ? Center(child: CircularProgressIndicator()) : _pages[_currentIndex],
      bottomNavigationBar: CustomNavigationBar(
        backgroundColor: Theme.of(context).dividerColor,
        isFloating: true,
        borderRadius: Radius.circular(26),
        iconSize: 52.0,
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
