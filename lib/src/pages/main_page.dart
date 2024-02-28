import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:minsait_tech_test/src/views/views.dart';
import 'package:minsait_tech_test/src/blocs/movies/movies_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
//  Index of current view
  late int _selectedIndex;

//  List of views
  final List<Widget> _views = [
    const ProfileView(),
    const MoviesView(),
    const MapView(),
  ];

  @override
  void initState() {
//  Set the initial index
    _selectedIndex = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MoviesBloc moviesBloc = context.watch<MoviesBloc>();

    return Scaffold(
      appBar: _selectedIndex == 0
          ? null
          : AppBar(
              title: Text('Minsait TechTest', style: Theme.of(context).textTheme.bodyMedium),
              actions: [
                Row(
                  children: [
                    _selectedIndex == 1
                        ? Switch(
                            value: moviesBloc.state.isOffLineMode,
                            activeColor: const Color(0xFF154c79),
                            thumbIcon: MaterialStatePropertyAll(
                              Icon(
                                moviesBloc.state.isOffLineMode ? Icons.wifi : Icons.wifi_off,
                                color: Colors.white,
                              ),
                            ),
                            onChanged: (value) => moviesBloc.runOffLineMode(value),
                          )
                        : const SizedBox(),
                  ],
                ),
              ],
            ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _views,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTap,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: AppLocalizations.of(context)!.profile,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.movie),
            label: AppLocalizations.of(context)!.movies,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.map),
            label: AppLocalizations.of(context)!.map,
          ),
        ],
      ),
    );
  }

//  Updates the selected index on tap
  void _onTap(int index) {
    setState(() => _selectedIndex = index);
  }
}
