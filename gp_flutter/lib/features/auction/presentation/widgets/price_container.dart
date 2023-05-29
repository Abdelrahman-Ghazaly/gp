import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PriceContainer extends StatelessWidget {
  const PriceContainer({
    super.key,
    required this.width,
    required this.height,
    required this.controller,
    required this.label,
    this.size,
  });
  final double? size;
  final double width;
  final double height;
  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size != null ? width * size! : width * 0.13,
      height: height * 0.07,
      child: TextField(
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
