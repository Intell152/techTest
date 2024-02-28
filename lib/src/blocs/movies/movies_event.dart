part of 'movies_bloc.dart';

sealed class MoviesEvent extends Equatable {
  const MoviesEvent();

  @override
  List<Object> get props => [];
}

final class GetNowPlayingMovies extends MoviesEvent {
  final List<Movie> nowPlayingMovies;
  const GetNowPlayingMovies(this.nowPlayingMovies);
}

final class GetTopRatedMovies extends MoviesEvent {
  final List<Movie> topRatedMovies;
  const GetTopRatedMovies(this.topRatedMovies);
}

final class GetUpcomingMovies extends MoviesEvent {
  final List<Movie> upcomingMovies;
  const GetUpcomingMovies(this.upcomingMovies);
}

final class GetActors extends MoviesEvent {
  final List<Actor> actors;
  const GetActors(this.actors);
}

final class ChangeConectionMode extends MoviesEvent {
  final bool isOffLineMode;
  const ChangeConectionMode(this.isOffLineMode);
}
