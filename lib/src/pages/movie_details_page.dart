import 'package:flutter/material.dart';

import 'package:minsait_tech_test/src/models/models.dart';
import 'package:minsait_tech_test/src/widgets/widgets.dart';

class MovieDetailsPage extends StatelessWidget {
  final Movie movie;

  const MovieDetailsPage({
    required this.movie,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(title: movie.name!, image: movie.poster!),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _MovieHeader(movie: movie),
                _Overview(description: movie.overview!),
                CardCarousel(id: movie.id),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final String title;
  final String image;

  const _CustomAppBar({
    required this.title,
    required this.image,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return SliverAppBar(
      expandedHeight: size.height * 0.2,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          child: Text(title, style: textTheme.bodyMedium),
        ),
        background: FadeInImage(
          image: NetworkImage(image),
          placeholder: const AssetImage('assets/images/loading.gif'),
          fit: BoxFit.cover,
          placeholderFit: BoxFit.contain,
        ),
      ),
    );
  }
}

class _MovieHeader extends StatelessWidget {
  final Movie movie;

  const _MovieHeader({
    required this.movie,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: size.width * 0.4,
              child: Hero(
                tag: movie.id,
                child: FadeInImage(
                  image: NetworkImage(movie.poster!),
                  placeholder: const AssetImage('assets/images/loading.gif'),
                  fit: BoxFit.cover,
                  placeholderFit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: size.width * 0.48,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.name!,
                  style: textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  movie.originalName!,
                  style: textTheme.bodySmall,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    const Icon(Icons.star, size: 15, color: Colors.white),
                    Text(
                      movie.rate.toString(),
                      style: textTheme.bodySmall,
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final String description;
  const _Overview({required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 10),
      child: Text(
        description,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
