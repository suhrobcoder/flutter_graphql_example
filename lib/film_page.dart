import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class FilmPage extends StatelessWidget {
  const FilmPage({super.key, required this.filmId});

  final String filmId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Query(
        options: QueryOptions(document: gql(film), variables: {
          "filmId": filmId,
        }),
        builder: (result, {fetchMore, refetch}) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }
          if (result.isLoading) {
            return const CircularProgressIndicator();
          }
          print(result.data);
          final movie = result.data?["film"];
          final characters = movie["characterConnection"]["characters"];
          return Column(
            children: [
              ListTile(
                title: Text(movie["title"]),
                subtitle: Text(movie["director"]),
                trailing: Text(movie["releaseDate"]),
              ),
              const Divider(),
              const Text("Characters"),
              const Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: characters.length,
                  itemBuilder: (context, index) {
                    final character = characters[index];
                    return ListTile(
                      title: Text(character["name"]),
                      subtitle: Text(character["gender"]),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

const film = """
query Film(\$filmId: ID) {
  film(id: \$filmId) {
    id
    title
    director
    releaseDate
    characterConnection {
      characters {
        id
        name
        gender
      }
    }
  }
}
""";
