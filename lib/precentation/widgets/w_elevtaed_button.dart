import 'package:flutter/material.dart';
import 'package:quagga/utils/colors.dart';

class WElevetedButton extends StatelessWidget {
  const WElevetedButton(
      {super.key, required this.onPressed, required this.title});
  final VoidCallback onPressed;
  final String title;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shadowColor: kPrimaryColor,
        backgroundColor: kOrangeColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        minimumSize: const Size(double.infinity, 60),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
