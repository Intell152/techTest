import 'package:bloc/bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:minsait_tech_test/src/pages/pages.dart';
import 'package:minsait_tech_test/src/models/models.dart';

// List of routes that help us navigate between pages
enum Routes {
  main,
  details,
}

// Route declaration
final appRoutes = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const MainPage()),
    GoRoute(
        path: '/details',
        builder: (context, state) {
          final Movie movie = Movie.fromObject(state.extra);
          return MovieDetailsPage(movie: movie);
        }),
  ],
);

// Router class with the corresponding methods for navigation
class RouterCubit extends Cubit<GoRouter> {
  RouterCubit() : super(appRoutes);

  void goBack() => state.canPop() ? state.pop() : null;

  void routesNavigator(Routes route, Movie? movie) {
    final Map<Routes, Function> navigateTo = {
      Routes.main: () => state.go(
            '/',
          ),
      Routes.details: () => state.push('/details', extra: movie),
    };

    navigateTo[route]!();
  }
}
