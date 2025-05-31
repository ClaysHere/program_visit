// ignore_for_file: depend_on_referenced_packages

import 'package:intl/intl.dart';

String formatTanggal(DateTime date) {
  return DateFormat('d MMMM y', 'id_ID').format(date);
}
