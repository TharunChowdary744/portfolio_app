import 'package:flutter/material.dart';
import 'package:portfolio/src/features/projects/presentation/project_screen.dart';
import 'package:get/get.dart';
import '../../settings/domain/profile.dart';
import '../domain/entities/project.dart';

class ProjectsScreen extends StatelessWidget {
  final List<Project> projects;
  final List<ProjectCategory> projectCategories;

  const ProjectsScreen({super.key, required this.projects, required this.projectCategories});

  @override
  Widget build(BuildContext context) {
    final ProjectsController controller = Get.put(ProjectsController(projectCategories));

    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Creations Showcase',
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                      'A concise tour of my handcrafted applications, reflecting my versatility and passion in tackling challenges across various development landscapes.',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w400,
                          )),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            SliverAppBar(
              collapsedHeight: 100,
              expandedHeight: 100,
              pinned: true,
              floating: true,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Explore",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 40,
                      child: Obx(() {
                        final selectedCategory = controller.selectedCategory.value;
                        return ListView.builder(
                            itemCount: projectCategories.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final isSelected = selectedCategory == projectCategories[index];
                              return GestureDetector(
                                onTap: () {
                                  controller.setCategory(isSelected ? null : projectCategories[index]);
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                      color: isSelected ? Theme.of(context).dividerColor : null,
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: Theme.of(context).dividerColor.withOpacity(0.3),
                                      )),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                                    child: Center(
                                      child: Text(
                                        projectCategories[index].name,
                                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                              color: isSelected ? Theme.of(context).scaffoldBackgroundColor : null,
                                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                      }),
                    ),
                  ],
                ),
              ),
            ),
            Obx(() {
              final filteredProjects = controller.filterProjectsByCategory(projects);
              if (filteredProjects.isEmpty) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      'No projects have been completed in this category',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                );
              }
              return SliverList.builder(
                  itemCount: filteredProjects.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(ProjectScreen(
                          project: filteredProjects[index],
                        ));
                      },
                      child: Container(
                        margin: (index == filteredProjects.length - 1) ? const EdgeInsets.only(bottom: 110) : const EdgeInsets.only(bottom: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 220,
                              decoration: BoxDecoration(
                                color: index % 2 == 0 ? Theme.of(context).dividerColor : Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.asset(
                                  filteredProjects[index].images.first,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    filteredProjects[index].name,
                                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  Text(
                                    filteredProjects[index].description,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 120,
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class ProjectsController extends GetxController {
  final List<ProjectCategory> projectCategories;
  var selectedCategory = Rxn<ProjectCategory>();

  ProjectsController(this.projectCategories) {
    if (projectCategories.isNotEmpty) {
      selectedCategory.value = projectCategories.first;
    }
  }

  void setCategory(ProjectCategory? category) {
    selectedCategory.value = category;
  }

  List<Project> filterProjectsByCategory(List<Project> projects) {
    if (selectedCategory.value == null) {
      return projects;
    }
    return projects.where((project) => project.categories[0].id.isEqual(selectedCategory.value!.id)).toList();
  }
}
