import 'package:flutter/material.dart';
import 'package:quagga/utils/colors.dart';

class SelectGender extends StatefulWidget {
  const SelectGender({
    required this.selectGender,
    super.key,
  });
  final Function(bool) selectGender;

  @override
  State<SelectGender> createState() => _SelectGenderState();
}

class _SelectGenderState extends State<SelectGender> {
  bool isMale = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select Gender",
          style: TextStyle(
            color: kGreyColor,
            fontSize: 16,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isMale = true;
                    widget.selectGender(isMale);
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: isMale ? kLightBlueColor : Colors.grey.shade800),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Male",
                    style: TextStyle(
                      color: kWhite,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isMale = false;
                    widget.selectGender(isMale);
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: isMale ? Colors.grey.shade800 : Colors.red),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Female",
                    style: TextStyle(
                      color: kWhite,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
