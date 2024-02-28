import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minsait_tech_test/src/blocs/movies/movies_bloc.dart';

class CardCarousel extends StatelessWidget {
  final int id;

  const CardCarousel({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MoviesBloc moviesBloc = context.watch<MoviesBloc>();

    return BlocBuilder<MoviesBloc, MoviesState>(
      builder: (context, state) {
        if (moviesBloc.state.actors.isEmpty) {
          moviesBloc.getCredits(id);
          return Center(child: Image.asset('assets/images/loading.gif'));
        } else {
          return Container(
            margin: const EdgeInsets.only(top: 10),
            width: double.infinity,
            height: 190,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              itemBuilder: (_, index) => _ActorCard(
                image: moviesBloc.state.actors[index].image!,
                name: moviesBloc.state.actors[index].name!,
              ),
            ),
          );
        }
      },
    );
  }
}

class _ActorCard extends StatelessWidget {
  final String image;
  final String name;

  const _ActorCard({
    required this.image,
    required this.name,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: 110,
        height: 100,
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                color: const Color(0xFF02284E),
                child: FadeInImage(
                  image: NetworkImage(image),
                  placeholder: const AssetImage('assets/images/loading.gif'),
                  fit: BoxFit.cover,
                  placeholderFit: BoxFit.contain,
                  width: double.infinity,
                  height: 150,
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              name,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: textTheme.bodySmall,
            )
          ],
        ),
      ),
    );
  }
}
