import 'package:flutter/material.dart';
import 'package:foodpanda_sellers_app/widgets/customeTextField.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController anyController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
        controller: anyController,
        data: Icons.phone,
        hintText: "Phone",
        isObsecure: false,
        enabled: false,),
      ],);
  }
}

