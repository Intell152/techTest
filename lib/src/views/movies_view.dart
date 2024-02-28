import 'package:flutter/material.dart';

import 'package:minsait_tech_test/src/widgets/widgets.dart';

class MoviesView extends StatelessWidget {
  const MoviesView({super.key});

  @override
  Widget build(BuildContext context) {

    return const SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //  Show Swiper with popular Movies
            MovieCardSwiper(),
            //  Show horisontal Slider with top rated Movies
            MovieSlider(),
            //  Show horisontal Slider with popular Movies
            MovieSlider(isUpcomingList: true),
          ],
        ),
      ),
    );
  }
}
