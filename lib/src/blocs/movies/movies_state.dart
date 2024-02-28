part of 'movies_bloc.dart';

class MoviesState extends Equatable {
  final List<Movie> nowPlayingMovies;
  final List<Movie> topRatedMovies;
  final List<Movie> upcomingMovies;
  final List<Actor> actors;
  final bool isOffLineMode;

  const MoviesState({
    this.nowPlayingMovies = const [],
    this.topRatedMovies = const [],
    this.upcomingMovies = const [],
    this.actors = const [],
    this.isOffLineMode = true,
  });

  MoviesState copyWith({
    List<Movie>? nowPlayingMovies,
    List<Movie>? topRatedMovies,
    List<Movie>? upcomingMovies,
    List<Actor>? actors,
    bool? isOffLineMode,
  }) =>
      MoviesState(
          nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
          topRatedMovies: topRatedMovies ?? this.topRatedMovies,
          upcomingMovies: upcomingMovies ?? this.upcomingMovies,
          actors: actors ?? this.actors,
          isOffLineMode: isOffLineMode ?? this.isOffLineMode);

  @override
  List<Object> get props => [nowPlayingMovies, topRatedMovies, upcomingMovies, actors, isOffLineMode];
}
