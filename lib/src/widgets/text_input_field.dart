import 'package:candela_maker/src/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class TextInputField extends StatelessWidget {
  final String name;
  final String? Function(String?)? validator;
  const TextInputField({
    super.key,
    required this.name,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14,
      ),
      cursorColor: Colors.white,
      name: name,
      validator: validator,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(top: 0.0, left: 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(
            width: 5.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(
            color: kPrimaryColor,
            width: 1.0,
          ),
        ),
      ),
    );
  }
}
