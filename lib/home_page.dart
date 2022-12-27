import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'film_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Query(
        options: QueryOptions(
          document: gql(allFilms),
        ),
        builder: (result, {fetchMore, refetch}) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }
          if (result.isLoading) {
            return const CircularProgressIndicator();
          }
          print(result.data);
          final movies = result.data?["allFilms"]["films"];
          return ListView.builder(
            itemBuilder: (context, index) {
              final movie = movies[index];
              return ListTile(
                title: Text(movie["title"]),
                subtitle: Text(movie["director"]),
                trailing: Text(movie["releaseDate"]),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FilmPage(
                        filmId: movie["id"],
                      ),
                    ),
                  );
                },
              );
            },
            itemCount: movies.length,
          );
        },
      ),
    );
  }
}

const allFilms = """
query Query {
  allFilms {
    films {
      id
      title
      director
      releaseDate
      speciesConnection {
        species {
          name
          classification
          homeworld {
            name
          }
        }
      }
    }
  }
}
""";
