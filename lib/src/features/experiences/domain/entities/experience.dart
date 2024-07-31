class Experience {
  final String id;
  final String title;
  final String description;
  final String startYear;
  final String endYear;
  final String logoUrl;
  final String city;
  final String country;
  final String company;
  final String? salary;
  final String time;
  final String workType;
  final List<Map<String, dynamic>> technologies;

  Experience({
    required this.id,
    required this.title,
    required this.description,
    required this.startYear,
    required this.endYear,
    required this.logoUrl,
    required this.city,
    required this.country,
    required this.company,
    this.salary,
    required this.time,
    required this.workType,
    required this.technologies,
  });
}

class Technologies {
  final String title;
  final String subTitle;

  Technologies({
    required this.title,
    required this.subTitle,
  });

  factory Technologies.fromMap(Map<String, dynamic> map) {
    return Technologies(
      title: map['title'],
      subTitle: map['subTitle'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subTitle': subTitle,
    };
  }
}
