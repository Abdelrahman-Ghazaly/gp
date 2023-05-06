import 'package:flutter/material.dart';

import '../../../../core/app_constants/app_colors.dart';

class FormTextField extends StatefulWidget {
  const FormTextField({
    super.key,
    this.isPassword = false,
    required this.icon,
    required this.labelText,
    required this.controller,
    required this.keyboardType,
    this.previousPassword,
    this.validator = _defaultValidator,
  });
  final bool isPassword;
  final IconData icon;
  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? previousPassword;
  final String? Function(String? value)? validator;

  @override
  State<FormTextField> createState() => _FormTextFieldState();
}

String? _defaultValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter some text';
  }
  return null;
}

class _FormTextFieldState extends State<FormTextField> {
  late bool isVisible = !widget.isPassword;

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      style: const TextStyle(fontSize: 15),
      obscureText: !isVisible,
      decoration: InputDecoration(
        prefixIcon: Icon(
          widget.icon,
        ),
        labelText: widget.labelText,
        labelStyle: const TextStyle(
          fontSize: 15,
        ),
        floatingLabelStyle: const TextStyle(
          fontSize: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.appGreemColor,
            width: 4,
          ),
          gapPadding: 5,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.appBlackColor,
            width: 1,
          ),
          gapPadding: 5,
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  isVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
                onPressed: () {
                  setState(
                    () {
                      isVisible = !isVisible;
                    },
                  );
                },
              )
            : null,
      ),
      validator: widget.validator,
    );
  }
}


//         if (widget.isPassword && value.length < 8) {
//           return 'Password must be 8 characters or more';
//         }
//         if (widget.isPassword && widget.previousPassword != null) {
//           if (value != widget.previousPassword) {
//             return 'The Passwords do not';
//           }
//         }
