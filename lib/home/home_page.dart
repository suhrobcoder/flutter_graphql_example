import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:star_wars_graphql/film/film_page.dart';
import 'package:star_wars_graphql/home/bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: Scaffold(
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const CircularProgressIndicator();
            }
            final movies = (state as HomeLoaded).films;
            return ListView.builder(
              itemBuilder: (context, index) {
                final movie = movies[index];
                return ListTile(
                  title: Text(movie.title),
                  subtitle: Text(movie.director),
                  trailing: Text(movie.releaseDate),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FilmPage(
                          filmId: movie.id,
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
      ),
    );
  }
}
