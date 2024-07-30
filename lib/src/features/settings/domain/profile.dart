class Profile {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String city;
  final String country;
  final List<SkillSet> skillSet;
  final List<ProjectCategory> projectCategories;
  final List<ProjectFeatures> projectFeatures;

  Profile({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.city,
    required this.country,
    required this.skillSet,
    required this.projectCategories,
    required this.projectFeatures,
  });

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      fullName: map['fullName'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      city: map['city'],
      country: map['country'],
      skillSet: List<Map<String, dynamic>>.from(map['skillSet'] ?? []).map((skill) => SkillSet.fromMap(skill)).toList(),
      projectCategories: List<Map<String, dynamic>>.from(map['projectCategories'] ?? []).map((skill) => ProjectCategory.fromMap(skill)).toList(),
      projectFeatures: List<Map<String, dynamic>>.from(map['projectFeatures'] ?? []).map((skill) => ProjectFeatures.fromMap(skill)).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'city': city,
      'country': country,
      'skillSet': skillSet.map((skill) => skill.toMap()).toList(),
      'projectCategories': projectCategories.map((category) => category.toMap()).toList(),
      'projectFeatures': projectFeatures.map((feature) => feature.toMap()).toList(),
    };
  }
}

class SkillSet {
  final String name;
  final String level;
  final String text;
  final String color;

  SkillSet({
    required this.name,
    required this.level,
    required this.text,
    required this.color,
  });

  factory SkillSet.fromMap(Map<String, dynamic> map) {
    return SkillSet(
      name: map['name'],
      level: map['level'],
      text: map['text'],
      color: map['color'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'level': level,
      'text': text,
      'color': color,
    };
  }
}


class ProjectCategory {
  final int id;
  final String name;

  ProjectCategory({
    required this.id,
    required this.name,
  });

  factory ProjectCategory.fromMap(Map<String, dynamic> map) {
    return ProjectCategory(
      id: map['id'] is String ? int.parse(map['id']) : map['id'],
      name: map['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}


class ProjectFeatures {
  final int id;
  final String name;
  final String icon;

  ProjectFeatures({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory ProjectFeatures.fromMap(Map<String, dynamic> map) {
    return ProjectFeatures(
      id: map['id'] is String ? int.parse(map['id']) : map['id'],
      name: map['name'], icon: map['icon'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
    };
  }
}
