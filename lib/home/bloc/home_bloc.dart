import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:star_wars_graphql/data/film.dart';
import 'package:star_wars_graphql/data/repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeLoading()) {
    on<Load>((event, emit) async {
      final result = await Repository.instance.getAllFilms();
      emit(HomeLoaded(result));
    });
    add(Load());
  }
}
