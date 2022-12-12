import 'package:intl/intl.dart';

class FormatUtil {
  static String doubleToReal(double? value) => value == null ? '' : NumberFormat.currency(locale: 'pt_BR', symbol: '', decimalDigits: 2).format(value);
}
