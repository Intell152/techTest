import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:minsait_tech_test/src/models/models.dart';
import 'package:minsait_tech_test/src/models/user.dart';
import 'package:minsait_tech_test/src/services/user_service.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  TextEditingController textEditingController = TextEditingController();

  final UserService _userService = UserService();

  ProfileCubit()
      : super(
          ProfileState(
            user: User(
              fullName: 'Jesús Angel Sosa Hernández',
              email: 'angelsosa152@gmail.com',
              phone: '5578655493',
              registerDate: '02-27-2024',
              image: '',
              banner: '',
              reviews: [
                'Increíble experiencia, código limpio y eficiente.',
                '¡Excelente comunicación y colaboración!',
              ],
            ),
            isLoading: true,
          ),
        );

  void changeLoadingState() {
    emit(state.copyWith(isLoading: !state.isLoading));
  }

  void getProfileData() async {
    final List<User> user = await _userService.getUser();

    // ignore: prefer_is_empty
    if (user.isNotEmpty) {
      emit(state.copyWith(user: user[0]));
    }
    changeLoadingState();
  }

  void changeProfileData(User user) async {
    emit(state.copyWith(user: user));

    await _userService.saveUser(state.user);
  }

  void addReview(String newReview) async {
    final List<String> reviews = state.user.reviews!;

    if (newReview.isNotEmpty) {
      reviews.add(newReview);

      final User user = User(
        fullName: null,
        email: null,
        phone: null,
        registerDate: null,
        image: null,
        banner: null,
        reviews: reviews,
      );

      emit(state.copyWith(user: user));
    }
  }
}
