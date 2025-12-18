import 'package:intl/intl.dart';

class CurrencyFormatter {
  CurrencyFormatter._(); // private constructor

  static final NumberFormat _vnd = NumberFormat.currency(
    locale: 'vi_VN',
    symbol: '₫',
    decimalDigits: 0,
  );

  static String formatVnd(num value) {
    return _vnd.format(value);
  }
}
