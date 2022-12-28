import 'package:star_wars_graphql/data/character.dart';

class Film {
  final String id;
  final String title;
  final String director;
  final String releaseDate;
  final List<Character> characters;

  Film({
    required this.id,
    required this.title,
    required this.director,
    required this.releaseDate,
    this.characters = const [],
  });

  factory Film.fromJson(Map<String, dynamic> json) => Film(
        id: json['id'],
        title: json['title'],
        director: json['director'],
        releaseDate: json['releaseDate'],
        characters: (json['characterConnection']?['characters'] as List?)
                ?.map((character) => Character.fromJson(character))
                .toList() ??
            [],
      );
}
