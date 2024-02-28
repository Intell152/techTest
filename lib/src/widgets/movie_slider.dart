import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:minsait_tech_test/src/routes/routes.dart';
import 'package:minsait_tech_test/src/blocs/movies/movies_bloc.dart';
import 'package:minsait_tech_test/src/models/models.dart';

class MovieSlider extends StatelessWidget {
  final bool isUpcomingList;

  const MovieSlider({
    this.isUpcomingList = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MoviesBloc moviesBloc = context.watch<MoviesBloc>();

    final Size size = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return BlocBuilder<MoviesBloc, MoviesState>(
      builder: (context, state) {
        if (!isUpcomingList && state.topRatedMovies.isEmpty) {
          moviesBloc.getTopRated();
          return Center(child: Image.asset('assets/images/loading.gif'));
        }

        if (isUpcomingList && state.upcomingMovies.isEmpty) {
          moviesBloc.getUpcoming();
          return Center(child: Image.asset('assets/images/loading.gif'));
        }

        return Container(
          width: double.infinity,
          height: size.height * 0.25,
          color: const Color(0xFF02284E),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  isUpcomingList ? AppLocalizations.of(context)!.upComing : AppLocalizations.of(context)!.topRated,
                  style: textTheme.bodyMedium,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 20,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, int index) => _MoviePoster(
                    movie: isUpcomingList
                        ? moviesBloc.state.upcomingMovies[index]
                        : moviesBloc.state.topRatedMovies[index],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class _MoviePoster extends StatelessWidget {
  final Movie movie;

  const _MoviePoster({
    required this.movie,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RouterCubit appRouter = context.watch<RouterCubit>();

    final TextTheme textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => appRouter.routesNavigator(Routes.details, movie),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          width: 100,
          height: 120,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  color: const Color(0xFF02284E),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Hero(
                      tag: movie.id,
                      child: FadeInImage(
                        image: NetworkImage(movie.poster!),
                        placeholder: const AssetImage('assets/images/loading.gif'),
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholderFit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  movie.name!,
                  style: textTheme.bodySmall,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
