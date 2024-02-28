import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:minsait_tech_test/src/models/models.dart';
import 'package:minsait_tech_test/src/routes/routes.dart';
import 'package:minsait_tech_test/src/widgets/widgets.dart';
import 'package:minsait_tech_test/src/blocs/profile/profile_cubit.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    // final Size size = MediaQuery.of(context).size;
    return const _ProfileForm();
  }
}

//  Show a Custom Unique Sliver AppBar
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
        background: Stack(
          fit: StackFit.expand,
          children: [
            FadeInImage(
              image: NetworkImage(image),
              placeholder: const AssetImage('assets/images/loading.gif'),
              fit: BoxFit.cover,
              placeholderFit: BoxFit.contain,
            ),
            Container(
              padding: const EdgeInsets.all(40),
              child: const Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/profile.png'),
                  ),
                  // SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget that provides the view content
class _ProfileForm extends StatefulWidget {
  const _ProfileForm({
    Key? key,
  }) : super(key: key);

  @override
  State<_ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<_ProfileForm> {
  late String _newReview;

  @override
  void initState() {
    _newReview = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ProfileCubit profileCubit = context.watch<ProfileCubit>();
    final RouterCubit appRouter = context.watch<RouterCubit>();

    final Size size = MediaQuery.of(context).size;

    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state.isLoading) {
          profileCubit.getProfileData();
          return Center(child: Image.asset('assets/images/loading.gif'));
        } else {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.85,
                  child: CustomScrollView(
                    slivers: [
                      const _CustomAppBar(
                        title: 'perfil',
                        image:
                            'https://media.istockphoto.com/id/1302189748/es/foto/ciberespacio-digital-con-part%C3%ADculas-y-conexiones-de-red-de-datos-digitales-concepto-de-fondo.jpg?s=612x612&w=0&k=20&c=e0gSOXwQt2KtPU3ipoPi312drSG1fgXJwblW-Y4FRhg=',
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Información del Usuario',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  CustomTextField(
                                    label: 'Nombre:',
                                    text: state.user.fullName!,
                                    onChange: (value) {
                                      final User user = User(
                                        fullName: value,
                                        email: null,
                                        phone: null,
                                        registerDate: null,
                                        image: null,
                                        banner: null,
                                        reviews: null,
                                      );
                                      profileCubit.changeProfileData(user);
                                      profileCubit.textEditingController.text = state.user.fullName!;
                                    },
                                  ),
                                  CustomTextField(
                                      label: 'Correo Electrónico:', text: state.user.email!, onChange: (value) {}),
                                  CustomTextField(label: 'Teléfono:', text: state.user.phone!, onChange: (value) {}),
                                  CustomTextField(
                                    label: 'Fecha de Registro:',
                                    text: state.user.registerDate!,
                                    onChange: (value) {},
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                  state.user.reviews!.length,
                                  (index) => ReviewItem(
                                    number: index,
                                    review: state.user.reviews![index],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                CustomFilledButton(
                  title: AppLocalizations.of(context)!.review,
                  onPressed: () {
//  Dialog to get a New Review
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Center(
                          child: Container(
                            width: size.width * 0.8,
                            height: size.height * 0.3,
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Material(
                                    color: Theme.of(context).cardColor,
                                    child: CustomTextField(
                                      label: 'Escribe tu Reseña:',
                                      text: '',
                                      onChange: (value) {
                                        setState(() {
                                          _newReview = value;
                                        });
                                      },
                                    ),
                                  ),
                                  CustomFilledButton(
                                    title: AppLocalizations.of(context)!.save,
                                    onPressed: () async {
                                      profileCubit.addReview(_newReview);
                                      setState(() {
                                        _newReview = '';
                                      });
                                      appRouter.goBack();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
