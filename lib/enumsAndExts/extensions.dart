extension DateFormat on DateTime{
  String get formatDate{
    return this.day.toString().padLeft(2, "0") +
        "/" +
        this.month.toString().padLeft(2, "0") +
        "/" +
        this.year.toString();
  }
}