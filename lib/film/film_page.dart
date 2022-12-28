import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_wars_graphql/film/bloc/film_bloc.dart';

class FilmPage extends StatelessWidget {
  const FilmPage({super.key, required this.filmId});

  final String filmId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FilmBloc(filmId),
      child: Scaffold(
        body: BlocBuilder<FilmBloc, FilmState>(
          builder: (context, state) {
            if (state is FilmLoading) {
              return const CircularProgressIndicator();
            }
            final movie = (state as FilmLoaded).film;
            final characters = movie.characters;
            return Column(
              children: [
                ListTile(
                  title: Text(movie.title),
                  subtitle: Text(movie.director),
                  trailing: Text(movie.releaseDate),
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
                        title: Text(character.name),
                        subtitle: Text(character.gender),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
