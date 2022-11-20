import 'package:intl/intl.dart';

class FormatacaoUtil {
  static String doubleToReal(double? value) => value == null ? '' : NumberFormat.currency(locale: 'pt_BR', symbol: '', decimalDigits: 2).format(value);
}
