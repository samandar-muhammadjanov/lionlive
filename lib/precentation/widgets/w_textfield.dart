// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quagga/utils/colors.dart';

class WTextField extends StatelessWidget {
  const WTextField(
      {super.key,
      required this.title,
      this.validator,
      this.onTap,
      this.hintText,
      this.suffix,
      this.maxLines = 1,
      this.controller,
      this.onEditingComplete,
      this.onFieldSubmitted,
      this.type,
      this.formatter,
      this.onChanged,
      this.readOnly,
      this.obscureText,
      this.prefix,
      this.style});
  final String title;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final Function(String)? onFieldSubmitted;
  final Function()? onEditingComplete;
  final String? hintText;
  final Widget? suffix;
  final int? maxLines;
  final TextEditingController? controller;
  final TextInputType? type;
  final List<TextInputFormatter>? formatter;
  final Function(String)? onChanged;
  final bool? readOnly;
  final bool? obscureText;
  final Widget? prefix;
  final TextStyle? style;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: kGreyColor, fontFamily: "sfPro"),
        ),
        const SizedBox(
          height: 14,
        ),
        TextFormField(
          obscureText: obscureText ?? false,
          readOnly: readOnly ?? false,
          inputFormatters: formatter,
          keyboardType: type,
          textInputAction: TextInputAction.done,
          controller: controller,
          onChanged: onChanged,
          onTap: onTap,
          validator: validator,
          style: style,
          onEditingComplete: onEditingComplete,
          maxLines: maxLines,
          onFieldSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            prefixIcon: prefix,
            hintText: hintText,
            suffixIcon: suffix,
            filled: true,
            fillColor: Colors.grey.shade200,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                color: kGreyColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
