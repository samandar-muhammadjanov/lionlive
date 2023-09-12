// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:quagga/utils/colors.dart';

class LoginForm extends StatefulWidget {
  LoginForm({
    super.key,
    required this.emailController,
    required this.isPasswrodVisible,
    required this.passwordController,
    required this.isEmail,
  });

  final TextEditingController emailController;
  bool isPasswrodVisible;
  final TextEditingController passwordController;
  final bool isEmail;
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Authintication",
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: kWhite,
                fontWeight: FontWeight.w700,
              ),
        ),
        const SizedBox(
          height: 30,
        ),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty || !value.contains("@")) {
              return "Not valid email";
            }
            return null;
          },
          key: const ValueKey("email"),
          controller: widget.emailController,
          decoration: InputDecoration(
            filled: true,
            fillColor: kGreyColor,
            hintText: widget.isEmail ? "Phone Number" : "Email",
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return "This field cannot be empty";
            }
            return null;
          },
          obscureText: widget.isPasswrodVisible,
          key: const ValueKey("password"),
          controller: widget.passwordController,
          decoration: InputDecoration(
            filled: true,
            fillColor: kGreyColor,
            hintText: "Password",
            suffixIcon: IconButton(
              onPressed: () => setState(
                  () => widget.isPasswrodVisible = !widget.isPasswrodVisible),
              icon: Icon(widget.isPasswrodVisible
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
