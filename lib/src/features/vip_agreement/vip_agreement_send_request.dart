import 'package:candela_maker/src/constants/constants.dart';
import 'package:candela_maker/src/widgets/input_field_title.dart';
import 'package:candela_maker/src/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class VIPAgreementSendRequest extends StatefulWidget {
  const VIPAgreementSendRequest({super.key});

  @override
  State<VIPAgreementSendRequest> createState() => _VIPAgreementSendRequestState();
}

class _VIPAgreementSendRequestState extends State<VIPAgreementSendRequest> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBgColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: kDefaultPadding,
            child: Column(
              children: [
                const SizedBox(height: 85),
                const Text(
                  "VIP AGREEMENT",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: kPrimaryColor,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset("assets/vip_agreement3_image1.png"),
                        Image.asset("assets/vip_agreement3_image2.png"),
                        Image.asset("assets/vip_agreement3_image3.png"),
                      ],
                    ),
                    const InputTitle(title: "Performer"),
                    const SizedBox(height: 9),
                    FormBuilderDropdown(
                      name: "membershipLevel",
                      items: const [],
                      decoration: InputDecoration(
                        contentPadding:
                            const EdgeInsets.only(top: 0.0, left: 10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 45),
                    const PrimaryButton(btnName: "Send Request"),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
