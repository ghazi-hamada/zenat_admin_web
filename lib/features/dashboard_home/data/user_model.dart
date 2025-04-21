class User {
  final int id;
  final String name;
  final int age;
  final String region;
  final String education;
  final int height;
  final String status;

  User({
    required this.id,
    required this.name,
    required this.age,
    required this.region,
    required this.education,
    required this.height,
    required this.status,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      region: json['region'],
      education: json['education'],
      height: json['height'],
      status: json['status'],
    );
  }
}