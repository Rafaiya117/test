class JobModel {
  final int id;
  final String title;
  final String description;
  final double salary;
  final String thumbnail;
  final String company;
  final String location;

  JobModel({
    required this.id,
    required this.title,
    required this.description,
    required this.salary,
    required this.thumbnail,
    required this.company,
    required this.location,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      salary: (json['price'] is int) ? (json['price'] as int).toDouble() : (json['price'] as num).toDouble(),
      thumbnail: json['thumbnail'] as String? ?? '',
      company: (json['brand'] ?? json['category'] ?? 'Acme Corp') as String,
      location: 'Dhaka, Bangladesh', // Dummy location - adapt as needed
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'salary': salary,
      'thumbnail': thumbnail,
      'company': company,
      'location': location,
    };
  }

  factory JobModel.fromLocalJson(Map<String, dynamic> json) {
    return JobModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      salary: (json['salary'] as num).toDouble(),
      thumbnail: json['thumbnail'],
      company: json['company'],
      location: json['location'],
    );
  }
}
