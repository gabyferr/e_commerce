import 'package:intl/intl.dart';

class FormatacaoUtil {
  static String doblueToReal(double value) {
    return NumberFormat.currency(locale: 'pt_BR', customPattern: '')
        .format(value);
  }
}
