import 'package:flutter/cupertino.dart';
import 'package:quagga/precentation/widgets/w_advertising.dart';

void showAd(BuildContext context) {
  showCupertinoDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) {
      return const Ad(
        key: ValueKey("ad"),
      );
    },
  );
}
