import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quagga/domain/repository/repository.dart';
import 'package:quagga/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class Ad extends StatefulWidget {
  const Ad({super.key});

  @override
  State<Ad> createState() => _AdState();
}

class _AdState extends State<Ad> {
  bool itsMonthly = true;
  List<Map<String, dynamic>> list = [
    {
      "title": "Send The Letter directly while video calling",
      "subtitle": "Send Messages Directly when Video Chatting",
      "image": "assets/images/letter.png"
    },
    {
      "title": "Unlimited Free Filters",
      "subtitle": "Filter by: Location, Age, Gender, etc.",
      "image": "assets/images/filter.png"
    },
    {
      "title": "Infinite Video Matches, Matches in general and DMs",
      "subtitle": "",
      "image": "assets/images/infinity.png"
    },
    {
      "title": "Enjoy the App without the Ads.",
      "subtitle": "",
      "image": "assets/images/block.png"
    },
    {
      "title": "Custom Emoji Profile Photo",
      "subtitle": "Select a Custom Emoji to Represent You",
      "image": "assets/images/king.png"
    }
  ];
  @override
  Widget build(BuildContext context) {
    return CupertinoDialogAction(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CupertinoButton(
                child: Icon(
                  CupertinoIcons.xmark_circle,
                  color: kOrangeColor,
                  size: 30,
                ),
                onPressed: () => Navigator.pop(context),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: kWhite,
            ),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 160,
                  child: PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      final item = list[index];
                      return Column(
                        children: [
                          Image.asset(
                            item["image"],
                            width: 100,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            item["title"],
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: kBlack,
                                fontFamily: "sfpro"),
                          ),
                          Text(
                            item["subtitle"],
                            style: TextStyle(
                                color: kBlack.withAlpha(150),
                                fontFamily: "sfpro"),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            itsMonthly = true;
                          });
                        },
                        child: Container(
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: itsMonthly
                                ? Border.all(color: kOrangeColor, width: 4)
                                : null,
                          ),
                          child: FractionallySizedBox(
                            heightFactor: 0.98,
                            widthFactor: 0.98,
                            child: Container(
                              height: 150,
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                              decoration: BoxDecoration(
                                color: kPrimaryColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: kOrangeColor,
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(12),
                                                    bottomLeft:
                                                        Radius.circular(4))),
                                        child: Text(
                                          "50% OFF",
                                          style: TextStyle(
                                            fontFamily: "sfpro",
                                            color: kWhite,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Text(
                                    "30",
                                    style: TextStyle(
                                      fontFamily: "sfpro",
                                      fontSize: 28,
                                      color: kWhite,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "Days",
                                    style: TextStyle(
                                      fontFamily: "sfpro",
                                      color: kWhite,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      style:
                                          const TextStyle(fontFamily: "sfpro"),
                                      children: [
                                        TextSpan(
                                          text: "\$27.99",
                                          style: TextStyle(
                                            fontFamily: "sfpro",
                                            color: kWhite,
                                            fontSize: 12,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                        const TextSpan(text: "  "),
                                        TextSpan(
                                          text: "\$11.99",
                                          style: TextStyle(
                                            fontFamily: "sfpro",
                                            fontSize: 15,
                                            color: kWhite,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            itsMonthly = false;
                          });
                        },
                        child: Container(
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: !itsMonthly
                                ? Border.all(color: kOrangeColor, width: 4)
                                : null,
                          ),
                          child: FractionallySizedBox(
                            heightFactor: 0.98,
                            widthFactor: 0.98,
                            child: Container(
                              height: 150,
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: kGreyColor,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "7",
                                    style: TextStyle(
                                      fontFamily: "sfpro",
                                      color: kBlack,
                                      fontSize: 28,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "Days",
                                    style: TextStyle(
                                      fontFamily: "sfpro",
                                      color: kBlack,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "\$5.99",
                                    style: TextStyle(
                                      fontFamily: "sfpro",
                                      fontSize: 15,
                                      color: kBlack,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final url = await Repository()
                        .buyPremiuim(itsMonthly ? "monthly" : "weekly");

                    if (!await launchUrl(Uri.parse(url),
                        mode: LaunchMode.externalApplication)) {
                      throw Exception('Could not launch');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shadowColor: kPrimaryColor,
                    backgroundColor: kOrangeColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: const Size(double.infinity, 60),
                  ),
                  child: const Text(
                    "Get it now!",
                    style: TextStyle(
                        fontFamily: 'sfPro',
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
