import 'package:graphql/client.dart';
import 'package:star_wars_graphql/data/queries.dart';

import 'film.dart';

class Repository {
  final client = createClient();

  static final Repository instance = Repository._privateConstructor();

  Repository._privateConstructor();

  Future<List<Film>> getAllFilms() async {
    final result = await client.query(QueryOptions(document: gql(allFilms)));
    return (result.data?['allFilms']['films'] as List?)
            ?.map((film) => Film.fromJson(film))
            .toList() ??
        [];
  }

  Future<Film> getFilmById(String id) async {
    final result = await client.query(QueryOptions(
      document: gql(film),
      variables: {
        "filmId": id,
      },
    ));
    return Film.fromJson(result.data?['film']);
  }
}

final httpLink =
    HttpLink("https://swapi-graphql.netlify.app/.netlify/functions/index");

GraphQLClient createClient() => GraphQLClient(
      cache: GraphQLCache(),
      link: httpLink,
    );
