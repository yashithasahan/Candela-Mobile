// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:candela_maker/src/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class TextInputField extends StatelessWidget {
  final String name;
  const TextInputField({
    Key? key,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderTextField(
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14,
      ),
      cursorColor: Colors.white,
      name: name,
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
