import 'package:candela_maker/src/constants/constants.dart';
import 'package:candela_maker/src/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../../common_widgets/account_check.dart';
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
    return PopScope(
        canPop: true,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: kBgColor,
            appBar: AppBar(
                forceMaterialTransparency: true,
                centerTitle: true,
                foregroundColor: kPrimaryColor,
                title: Text(
                  'signin'.tr,
                  style: const TextStyle(
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
                    InputTitle(title: "email".tr),
                    const SizedBox(height: 9),
                    TextInputField(
                      name: "email",
                      keyboard: TextInputType.emailAddress,
                      validator: FormBuilderValidators.required(
                          errorText: "email-empty".tr),
                    ),
                    const SizedBox(height: 21),
                    InputTitle(title: "password".tr),
                    const SizedBox(height: 9),
                    TextInputField(
                      name: "password",
                      keyboard: TextInputType.visiblePassword,
                      validator: FormBuilderValidators.required(
                          errorText: "password-empty".tr),
                    ),
                    const SizedBox(height: 25),
                    isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                            color: kPrimaryColor,
                          ))
                        : PrimaryButton(
                            btnName: "login".tr,
                            press: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                final email = _formKey
                                    .currentState!.fields['email']?.value
                                    ?.replaceAll(RegExp(r"\s"), "")
                                    ?.trim();

                                final password = _formKey
                                    .currentState!.fields['password']!.value
                                    .trim();

                                await AuthService()
                                    .login(email, password, context);

                                setState(() {
                                  isLoading = false;
                                });
                              }
                            },
                          ),
                    const SizedBox(height: 10),
                    const AccountCheck(login: true),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
