class Expense {
  late String id;
  final String title;
  final double amount;
  final String date;

  Expense({
    required this.title,
    required this.amount,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'amount': amount,
      'date': date,
    };
  }
}
