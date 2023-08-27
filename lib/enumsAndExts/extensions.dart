extension DateFormat on DateTime {
  String get formatDate {
    return "${day.toString().padLeft(2, "0")}/${month.toString().padLeft(2, "0")}/$year";
  }
}
