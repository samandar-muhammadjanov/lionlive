import 'package:intl/intl.dart';

extension NumberFormattingExtensions on num {
  String formatWithSpaces({String locale = 'en_US'}) {
    final numberFormat = NumberFormat.decimalPattern(locale);
    return numberFormat.format(this).replaceAll(',', ' ');
  }
}
