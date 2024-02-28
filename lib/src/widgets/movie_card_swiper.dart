import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

import 'package:minsait_tech_test/src/routes/routes.dart';
import 'package:minsait_tech_test/src/blocs/movies/movies_bloc.dart';

class MovieCardSwiper extends StatelessWidget {
  const MovieCardSwiper({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RouterCubit appRouter = context.watch<RouterCubit>();
    final MoviesBloc moviesBloc = context.watch<MoviesBloc>();

    final Size size = MediaQuery.of(context).size;

    return BlocBuilder<MoviesBloc, MoviesState>(
      builder: (context, state) {
        if (state.nowPlayingMovies.isEmpty) {
          moviesBloc.getNowPlaying();
          return Center(child: Image.asset('assets/images/loading.gif'));
        } else {
          return SizedBox(
            width: double.infinity,
            height: size.height * 0.5,
            child: CardSwiper(
              cardsCount: 10,
              padding: EdgeInsets.symmetric(vertical: 50, horizontal: size.width * 0.20),
              numberOfCardsDisplayed: 4,
              maxAngle: 90,
              backCardOffset: const Offset(-30, 0),
              cardBuilder: (context, int index, horizontalOffsetPercentage, verticalOffsetPercentage) {
                return GestureDetector(
                  onTap: () => appRouter.routesNavigator(Routes.details, moviesBloc.state.nowPlayingMovies[index]),
                  child: Card(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Hero(
                        tag: moviesBloc.state.nowPlayingMovies[index].id,
                        child: FadeInImage(
                          image: NetworkImage(moviesBloc.state.nowPlayingMovies[index].poster!),
                          placeholder: const AssetImage('assets/images/loading.gif'),
                          fit: BoxFit.cover,
                          placeholderFit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
