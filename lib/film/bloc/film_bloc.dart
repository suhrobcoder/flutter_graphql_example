import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:star_wars_graphql/data/film.dart';
import 'package:star_wars_graphql/data/repository.dart';

part 'film_event.dart';
part 'film_state.dart';

class FilmBloc extends Bloc<FilmEvent, FilmState> {
  final String id;

  FilmBloc(this.id) : super(FilmLoading()) {
    on<Load>((event, emit) async {
      final result = await Repository.instance.getFilmById(event.id);
      emit(FilmLoaded(result));
    });
    add(Load(id));
  }
}
