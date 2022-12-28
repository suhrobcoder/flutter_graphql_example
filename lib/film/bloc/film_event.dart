part of 'film_bloc.dart';

@immutable
abstract class FilmEvent {}

class Load extends FilmEvent {
  final String id;

  Load(this.id);
}
