import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:minsait_tech_test/src/theme/theme.dart';
import 'package:minsait_tech_test/src/routes/routes.dart';
import 'package:minsait_tech_test/src/blocs/map/map_cubit.dart';
import 'package:minsait_tech_test/src/blocs/profile/profile_cubit.dart';
import 'package:minsait_tech_test/src/blocs/movies/movies_bloc.dart';
import 'package:minsait_tech_test/src/services/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
//  Service initializer when running app
  await serviceLocatorInit();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (value) => runApp(
      const BlocsProvider(),
    ),
  );

  runApp(const BlocsProvider());
}

//  Create the global Blocks of the app
class BlocsProvider extends StatelessWidget {
  const BlocsProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_) => getIt<RouterCubit>()),
      BlocProvider(create: (_) => getIt<MoviesBloc>()),
      BlocProvider(create: (_) => getIt<MapCubit>()),
      BlocProvider(create: (_) => getIt<ProfileCubit>()),
    ], child: const MyApp());
  }
}

//  App Globar configuration
class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appRouter = context.watch<RouterCubit>().state;

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Minsait Movie Tech Test App',
      theme: lightTheme,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
      ],
      routerConfig: appRouter,
    );
  }
}
