import 'package:flutter/material.dart';
import '../../../mock/experience_mock.dart';
import '../domain/entities/experience.dart';

class ExperienceScreen extends StatelessWidget {
  final Experience experience;

  const ExperienceScreen({
    super.key,
    required this.experience,
  });

  @override
  Widget build(BuildContext context) {
    /* final Experience experience = mockedExperiences.firstWhere(
      (element) => element.id == experienceId,
    );*/
    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverAppBar(
            primary: true,
            stretch: true,
            expandedHeight: 350,
            collapsedHeight: 100,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            flexibleSpace: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                child: Center(
                  child: SizedBox(
                    height: 140,
                    child: ClipRRect(borderRadius: BorderRadius.circular(20), child: Image.network("${experience.logoUrl}")),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: MediaQuery.of(context).size.height / 1.5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                  color: Color(0xFF232323)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 5,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: CustomScrollView(
                        slivers: [
                          SliverAppBar(
                            expandedHeight: 60,
                            collapsedHeight: 54,
                            toolbarHeight: 30,
                            pinned: true,
                            floating: true,
                            surfaceTintColor: const Color(0xFF232323),
                            backgroundColor: const Color(0xFF232323),
                            automaticallyImplyLeading: false,
                            flexibleSpace: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${experience.company} - ${experience.city}, ${experience.country}",
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                          color: (Theme.of(context).brightness == Brightness.light)
                                              ? Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7)
                                              : Theme.of(context).dividerColor.withOpacity(0.7),
                                          fontWeight: FontWeight.bold,
                                        )),
                                Text(experience.title,
                                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                          color: (Theme.of(context).brightness == Brightness.light)
                                              ? Theme.of(context).scaffoldBackgroundColor
                                              : Theme.of(context).dividerColor,
                                          fontWeight: FontWeight.bold,
                                        )),
                              ],
                            ),
                          ),
                          SliverList(
                            delegate: SliverChildListDelegate(
                              [
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    if (experience.salary != null)
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/icons/png/salary.png",
                                            height: 32,
                                          ),
                                          const SizedBox(width: 10),
                                          Text("${experience.salary}",
                                              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                                    color: (Theme.of(context).brightness == Brightness.light)
                                                        ? Theme.of(context).scaffoldBackgroundColor
                                                        : Theme.of(context).dividerColor,
                                                  )),
                                        ],
                                      ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/icons/png/duration.png",
                                          height: 32,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(experience.time,
                                            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                                  color: (Theme.of(context).brightness == Brightness.light)
                                                      ? Theme.of(context).scaffoldBackgroundColor
                                                      : Theme.of(context).dividerColor,
                                                )),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/icons/png/workplace.png",
                                          height: 32,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(experience.workType,
                                            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                                  color: (Theme.of(context).brightness == Brightness.light)
                                                      ? Theme.of(context).scaffoldBackgroundColor
                                                      : Theme.of(context).dividerColor,
                                                )),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Key Information",
                                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                              fontSize: 20,
                                              color: (Theme.of(context).brightness == Brightness.light)
                                                  ? Theme.of(context).scaffoldBackgroundColor
                                                  : Theme.of(context).dividerColor,
                                            )),
                                    const SizedBox(height: 4),
                                    Text(
                                      experience.description,
                                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                            fontSize: 14,
                                            color: (Theme.of(context).brightness == Brightness.light)
                                                ? Theme.of(context).scaffoldBackgroundColor
                                                : Theme.of(context).dividerColor,
                                          ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Technologies",
                                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                              fontSize: 20,
                                              color: (Theme.of(context).brightness == Brightness.light)
                                                  ? Theme.of(context).scaffoldBackgroundColor
                                                  : Theme.of(context).dividerColor,
                                            )),
                                    const SizedBox(height: 4),
                                    SizedBox(
                                      height: 58,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: experience.technologies.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            margin: const EdgeInsets.only(right: 20),
                                            child: Row(
                                              children: [
                                                Container(
                                                    width: 58,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(12),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(12),
                                                      child: Image.asset(
                                                        "assets/icons/tech/flutter.png",
                                                      ),
                                                    )),
                                                const SizedBox(width: 10),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "${experience.technologies[index]['title']}",
                                                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                                            color: (Theme.of(context).brightness == Brightness.light)
                                                                ? Theme.of(context).scaffoldBackgroundColor
                                                                : Theme.of(context).dividerColor,
                                                          ),
                                                    ),
                                                    Text(
                                                      "${experience.technologies[index]['subTitle']}",
                                                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                                            color: (Theme.of(context).brightness == Brightness.light)
                                                                ? Theme.of(context).scaffoldBackgroundColor
                                                                : Theme.of(context).dividerColor,
                                                          ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 110),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
