import 'package:candela_maker/src/constants/constants.dart';
import 'package:candela_maker/src/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../widgets/input_field_title.dart';
import '../../../widgets/text_input_field.dart';
import '../services/auth_service.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {


  final _formKey = GlobalKey<FormBuilderState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBgColor,
        appBar: AppBar(
            forceMaterialTransparency: true,
            automaticallyImplyLeading: false,
            centerTitle: true,
            foregroundColor: kTextColor,
            title: const Text(
              'SIGN IN',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: kPrimaryColor,
              ),
            )),
        body: Padding(
            padding: kDefaultPadding,
            child: FormBuilder(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const InputTitle(title: "Email"),
                  const SizedBox(height: 9),
                  TextInputField(
                    name: "email",
                    validator: FormBuilderValidators.required(
                        errorText: "Email can not be empty"),
                  ),
                  const SizedBox(height: 21),
                  const InputTitle(title: "Password"),
                  const SizedBox(height: 9),
                  TextInputField(
                    name: "password",
                    validator: FormBuilderValidators.required(
                        errorText: "Password can not be empty"),
                  ),
                  const SizedBox(height: 25),
                  isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                          color: kPrimaryColor,
                        ))
                      : PrimaryButton(
                          btnName: "Sign In",
                          press: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              final email = _formKey
                                  .currentState!.fields['email']!.value
                                  .toString();
                              final password = _formKey
                                  .currentState!.fields['password']!.value
                                  .toString();
                              await AuthService()
                                  .login(email, password, context);

                              setState(() {
                                isLoading = false;
                              });
                            }
                          },
                        ),
                  const SizedBox(height: 20),
                ],
              ),
            )),
      ),
    );
  }
}
