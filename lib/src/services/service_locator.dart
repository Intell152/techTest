import 'package:get_it/get_it.dart';

import 'package:minsait_tech_test/src/routes/routes.dart';
import 'package:minsait_tech_test/src/blocs/map/map_cubit.dart';
import 'package:minsait_tech_test/src/blocs/movies/movies_bloc.dart';
import 'package:minsait_tech_test/src/blocs/profile/profile_cubit.dart';

GetIt getIt = GetIt.instance;

Future<void> serviceLocatorInit() async {
  getIt.registerSingleton(RouterCubit());
  getIt.registerSingleton(MoviesBloc());
  getIt.registerSingleton(MapCubit());
  getIt.registerSingleton(ProfileCubit());
}
