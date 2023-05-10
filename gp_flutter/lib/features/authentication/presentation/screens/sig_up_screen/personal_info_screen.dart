import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/app_constants/app_constants.dart';
import '../../../../../core/utils/utilities.dart';
import '../../../data/models/user_model.dart';
import '../../bloc/sign_up_bloc/sign_up_bloc.dart';
import '../../widgets/form_text_field.dart';
import '../log_in_screen.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({
    Key? key,
    required this.email,
    required this.password,
  }) : super(key: key);
  final String email;
  final String password;

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late TextEditingController _firstName;
  late TextEditingController _lastName;
  late TextEditingController _phoneNumber;
  late TextEditingController _address;
  late UserModel userModel;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 2,
      ),
    )..animateTo(0.5);
    _firstName = TextEditingController();
    _lastName = TextEditingController();
    _phoneNumber = TextEditingController();
    _address = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LottieBuilder.asset(
                    AppAnimations.lottiePersonalIdAnimation,
                    height: Utilities.screenHeight * 0.25,
                    controller: _controller,
                  ),
                  Text(
                    'Finishing Touches',
                    style: AppTextStyles.appBarTextStyle,
                    textAlign: TextAlign.center,
                  ),
                  kSpacing(15),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        FormTextField(
                          icon: Icons.perm_identity_outlined,
                          labelText: 'First Name',
                          controller: _firstName,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your first name';
                            }
                            return null;
                          },
                        ),
                        kSpacing(15),
                        FormTextField(
                          icon: Icons.perm_identity_outlined,
                          labelText: 'Last Name',
                          controller: _lastName,
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your last name';
                            }
                            return null;
                          },
                        ),
                        kSpacing(15),
                        FormTextField(
                          icon: Icons.phone_outlined,
                          labelText: 'Phone Number',
                          controller: _phoneNumber,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            return null;
                          },
                        ),
                        kSpacing(15),
                        FormTextField(
                          icon: Icons.house_outlined,
                          labelText: 'Address',
                          controller: _address,
                          keyboardType: TextInputType.streetAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your address';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              userModel = UserModel(
                name: '${_firstName.text} ${_lastName.text}',
                password: widget.password,
                email: widget.email,
                address: _address.text,
                phoneNumber: _phoneNumber.text,
              );
              context.read<SignUpBloc>().add(
                    PostDataEvent(userModel: userModel),
                  );
              BlocListener<SignUpBloc, SignUpState>(
                listener: (context, state) async {
                  if (state is Success) {
                    showDialog(
                      context: context,
                      builder: (_) => SizedBox(
                        height: Utilities.screenHeight * 0.5,
                        width: Utilities.screenWidth * 0.8,
                        child: Center(
                          child: Lottie.asset(
                            AppAnimations.lottieAccountCreatedAnimation,
                          ),
                        ),
                      ),
                    );
                    await Future.delayed(
                      const Duration(seconds: 1),
                      () {
                        Utilities().pushTo(
                          context,
                          screen: const LogInScreen(),
                        );
                      },
                    );
                  } else {}
                },
              );
            }
          },
          style: ElevatedButton.styleFrom(
            minimumSize: Size(Utilities.screenWidth, 50),
          ),
          child: const Text('Sign Up'),
        ),
      ),
    );
  }
}
