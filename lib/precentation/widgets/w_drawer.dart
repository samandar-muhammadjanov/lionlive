import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:quagga/utils/colors.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool itRandom = true;
  bool isSolo = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        elevation: 0,
        backgroundColor: kPrimaryColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Set Filters",
                style: TextStyle(
                    fontSize: 20, color: kWhite, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Select Location:",
                style: TextStyle(fontSize: 18, color: kGreyColor),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    itRandom = false;
                  });
                },
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(8),
                  color: kLightBlueColor,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: !itRandom
                            ? kLightBlueColor.withOpacity(0.2)
                            : Colors.transparent),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: Row(
                      children: [
                        Text(
                          "📍",
                          style: TextStyle(
                              color: kWhite,
                              fontWeight: FontWeight.w700,
                              fontSize: 20),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Nearby",
                          style: TextStyle(
                            color: kWhite,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    itRandom = true;
                  });
                },
                child: DottedBorder(
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(8),
                  color: kLightBlueColor,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: itRandom
                            ? kLightBlueColor.withOpacity(0.2)
                            : Colors.transparent),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: Row(
                      children: [
                        Text(
                          "🌍",
                          style: TextStyle(
                            color: kWhite,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Random",
                          style: TextStyle(
                            color: kWhite,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // const SizedBox(
              //   height: 20,
              // ),
              // Text(
              //   "Select Peers:",
              //   style: TextStyle(fontSize: 18, color: kGreyColor),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // InkWell(
              //   onTap: () {
              //     setState(() {
              //       isSolo = false;
              //     });
              //   },
              //   child: DottedBorder(
              //     borderType: BorderType.RRect,
              //     radius: const Radius.circular(8),
              //     color: kLightBlueColor,
              //     child: Container(
              //       width: double.infinity,
              //       decoration: BoxDecoration(
              //           color: !isSolo
              //               ? kLightBlueColor.withOpacity(0.2)
              //               : Colors.transparent),
              //       padding: const EdgeInsets.symmetric(
              //         horizontal: 10,
              //         vertical: 10,
              //       ),
              //       child: Row(
              //         children: [
              //           Text(
              //             "☝",
              //             style: TextStyle(
              //               color: kWhite,
              //               fontWeight: FontWeight.w700,
              //               fontSize: 20,
              //             ),
              //           ),
              //           const SizedBox(
              //             width: 10,
              //           ),
              //           Text(
              //             "Solo",
              //             style: TextStyle(
              //               color: kWhite,
              //               fontWeight: FontWeight.w700,
              //               fontSize: 20,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // InkWell(
              //   onTap: () {
              //     setState(() {
              //       isSolo = true;
              //     });
              //   },
              //   child: DottedBorder(
              //     borderType: BorderType.RRect,
              //     radius: const Radius.circular(8),
              //     color: kLightBlueColor,
              //     child: Container(
              //       width: double.infinity,
              //       decoration: BoxDecoration(
              //           color: isSolo
              //               ? kLightBlueColor.withOpacity(0.2)
              //               : Colors.transparent),
              //       padding: const EdgeInsets.symmetric(
              //         horizontal: 10,
              //         vertical: 10,
              //       ),
              //       child: Row(
              //         children: [
              //           Text(
              //             "✌️",
              //             style: TextStyle(
              //               color: kWhite,
              //               fontWeight: FontWeight.w700,
              //               fontSize: 20,
              //             ),
              //           ),
              //           const SizedBox(
              //             width: 10,
              //           ),
              //           Text(
              //             "Duo",
              //             style: TextStyle(
              //               color: kWhite,
              //               fontWeight: FontWeight.w700,
              //               fontSize: 20,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
