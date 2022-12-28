class Character {
  final String id;
  final String name;
  final String gender;

  Character({
    required this.id,
    required this.name,
    required this.gender,
  });

  factory Character.fromJson(Map<String, dynamic> json) => Character(
        id: json['id'],
        name: json['name'],
        gender: json['gender'],
      );
}
