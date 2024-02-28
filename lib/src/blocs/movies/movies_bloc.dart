import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'package:minsait_tech_test/src/models/models.dart';
import 'package:minsait_tech_test/src/services/services.dart';

part 'movies_event.dart';
part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {

  MoviesService moviesService = MoviesService();
  ActorService actorService = ActorService();

  MoviesBloc() : super(const MoviesState()) {
    on<GetNowPlayingMovies>((event, emit) => emit(state.copyWith(nowPlayingMovies: event.nowPlayingMovies)));
    on<GetTopRatedMovies>((event, emit) => emit(state.copyWith(topRatedMovies: event.topRatedMovies)));
    on<GetUpcomingMovies>((event, emit) => emit(state.copyWith(upcomingMovies: event.upcomingMovies)));
    on<GetActors>((event, emit) => emit(state.copyWith(actors: event.actors)));
    on<ChangeConectionMode>((event, emit) => emit(state.copyWith(isOffLineMode: event.isOffLineMode)));

    // _connectivityController.init();
  }

  Future<void> runOffLineMode(bool value) async {
    resetMovies();
    add(ChangeConectionMode(value));
    if (!value) {
      final List<Movie> moviesList = await moviesService.getAllMovies();
      final List<Actor> actorsList = await actorService.getAllActors();

      add(GetNowPlayingMovies(moviesList.where((movie) => movie.type == 0).toList()));
      add(GetTopRatedMovies(moviesList.where((movie) => movie.type == 1).toList()));
      add(GetUpcomingMovies(moviesList.where((movie) => movie.type == 2).toList()));
      add(GetActors(actorsList));
      return;
    }
  }

  void resetMovies() {
    add(const GetNowPlayingMovies([]));
    add(const GetTopRatedMovies([]));
    add(const GetUpcomingMovies([]));
    add(const GetActors([]));
  }

  Future<bool> thereisconnection() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (!state.isOffLineMode) return false;
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }

    return false;
  }

// type 0
  Future<bool> getNowPlaying() async {
    if (await thereisconnection() == false) return false;

    final Uri url = Uri.https(dotenv.env['URLBASE']!, '3/movie/now_playing', {
      'api_key': dotenv.env['APIKEY'],
      'languag': dotenv.env['LANG'],
      'page': '1',
    });

    final result = await http.get(url);

    if (result.statusCode != 200) return false;

    final Map<String, dynamic> parsed = json.decode(result.body);
    final list = parsed['results'].map((json) => Movie.fromJson(json, 0)).toList().cast<Movie>();

    add(GetNowPlayingMovies(list));

    list.forEach((Movie movie) {
      moviesService.saveMovie(movie);
    });

    return true;
  }

// type 1
  Future<bool> getTopRated() async {
    if (await thereisconnection() == false) return false;

    final Uri url = Uri.https(dotenv.env['URLBASE']!, '3/movie/top_rated', {
      'api_key': dotenv.env['APIKEY'],
      'languag': dotenv.env['LANG'],
      'page': '1',
    });

    final result = await http.get(url);

    if (result.statusCode != 200) return false;

    final Map<String, dynamic> parsed = json.decode(result.body);
    final list = parsed['results'].map((json) => Movie.fromJson(json, 1)).toList().cast<Movie>();

    add(GetTopRatedMovies(list));

    list.forEach((Movie movie) {
      moviesService.saveMovie(movie);
    });

    return true;
  }

// type 2
  Future<bool> getUpcoming() async {
    if (await thereisconnection() == false) return false;

    final Uri url = Uri.https(dotenv.env['URLBASE']!, '3/movie/upcoming', {
      'api_key': dotenv.env['APIKEY'],
      'languag': dotenv.env['LANG'],
      'page': '1',
    });

    final result = await http.get(url);

    if (result.statusCode != 200) return false;

    final Map<String, dynamic> parsed = json.decode(result.body);
    final list = parsed['results'].map((json) => Movie.fromJson(json, 2)).toList().cast<Movie>();

    add(GetUpcomingMovies(list));

    list.forEach((Movie movie) {
      moviesService.saveMovie(movie);
    });

    return true;
  }

  Future<bool> getCredits(int id) async {
    if (await thereisconnection() == false) return false;

    final Uri url = Uri.https(dotenv.env['URLBASE']!, '3/movie/${id.toString()}/credits', {
      'api_key': dotenv.env['APIKEY'],
      'languag': dotenv.env['LANG'],
      'page': '1',
    });

    final result = await http.get(url);

    if (result.statusCode != 200) return false;

    final Map<String, dynamic> parsed = json.decode(result.body);
    final list = parsed['cast'].map((json) => Actor.fromJson(json, id)).toList().cast<Actor>();

    add(GetActors(list));

    list.forEach((Actor actor) {
      actorService.saveActor(actor);
    });

    return true;
  }
}
