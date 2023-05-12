import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/common_widgets/common_widgets.dart'
    hide CustomAppBar;
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
    with TickerProviderStateMixin {
  late AnimationController _idController;
  late AnimationController _doneController;
  late TextEditingController _firstName;
  late TextEditingController _lastName;
  late TextEditingController _phoneNumber;
  late TextEditingController _address;
  late UserModel userModel;

  @override
  void initState() {
    _idController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 2,
      ),
    )..animateTo(0.5);
    _doneController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 2,
      ),
    );
    _firstName = TextEditingController();
    _lastName = TextEditingController();
    _phoneNumber = TextEditingController();
    _address = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _idController.dispose();
    _doneController.dispose();
    _firstName.dispose();
    _lastName.dispose();
    _phoneNumber.dispose();
    _address.dispose();

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
                    controller: _idController,
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
      bottomNavigationBar: BlocListener<SignUpBloc, SignUpState>(
        listener: (context, state) {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: Container(
                  height: Utilities.screenHeight * 0.4,
                  width: Utilities.screenWidth * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 15,
                          color: Colors.black.withOpacity(0.2),
                          offset: const Offset(0.5, 0.5))
                    ],
                  ),
                  child: _buildDialog(
                    context,
                    state: state,
                    doneController: _doneController,
                  ),
                ),
              );
            },
          );
        },
        child: Padding(
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
              }
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(Utilities.screenWidth, 50),
            ),
            child: const Text('Sign Up'),
          ),
        ),
      ),
    );
  }
}

Widget _buildDialog(
  BuildContext context, {
  required SignUpState state,
  required AnimationController doneController,
}) {
  if (state is Success) {
    doneController.forward();
    return Center(
      child: Column(
        children: [
          Lottie.asset(
            AppAnimations.lottieAccountCreatedAnimation,
            controller: doneController,
          ),
          ElevatedButton(
            onPressed: () {
              Utilities().pushTo(
                context,
                screen: const LogInScreen(),
              );
            },
            child: const Text('Log in'),
          ),
        ],
      ),
    );
  } else if (state is Error) {
    return Center(
      child: Text(
        state.message,
        style: AppTextStyles.appBarTextStyle,
      ),
    );
  } else {
    return const Center(
      child: LoadingWidget(),
    );
  }
}
