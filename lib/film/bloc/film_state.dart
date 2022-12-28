part of 'film_bloc.dart';

@immutable
abstract class FilmState {}

class FilmLoading extends FilmState {}

class FilmLoaded extends FilmState {
  final Film film;

  FilmLoaded(this.film);
}
