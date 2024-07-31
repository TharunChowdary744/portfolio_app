import 'dart:ui';

import 'package:portfolio/src/features/projects/domain/entities/project_category.dart';
import 'package:portfolio/src/features/projects/domain/entities/project_feature.dart';

import '../../../settings/domain/profile.dart';


class Project {
  final String id;
  final String name;
  final String description;
  final String workType;
  final Color color;
  final List<ProjectCategory> categories;
  final List<ProjectFeatures> features;
  final String? getStartedUrl;
  final String? watchDemoUrl;
  final String? githubUrl;
  final List<String> images;

  Project({
    required this.id,
    required this.name,
    required this.description,
    required this.workType,
    required this.color,
    required this.categories,
    required this.features,
    this.getStartedUrl,
    this.watchDemoUrl,
    this.githubUrl,
    required this.images,
  });
}

