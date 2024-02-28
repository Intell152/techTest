part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  final User user;
  final bool isLoading;

  const ProfileState({
    required this.user,
    required this.isLoading,
  });

  ProfileState copyWith({
    User? user,
    bool? isLoading,
  }) =>
      ProfileState(
        user: User(
          fullName: user?.fullName ?? this.user.fullName,
          email: user?.email ?? this.user.email,
          phone: user?.phone ?? this.user.phone,
          registerDate: user?.registerDate ?? this.user.registerDate,
          image: user?.image ?? this.user.image,
          banner: user?.banner ?? this.user.banner,
          reviews: user?.reviews ?? this.user.reviews,
        ),
        isLoading: isLoading ?? this.isLoading,
      );

  @override
  List<Object> get props => [user, isLoading];
}
