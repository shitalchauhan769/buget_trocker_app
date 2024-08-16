class EntryModel {
  int? id, status;
  String? title, category, date, time,amount;

  EntryModel(
      {this.id,
      this.status,
      this.title,
      this.amount,
      this.category,
      this.date,
      this.time});

  factory EntryModel.MapToModel(Map m1) {
    return EntryModel(
        id: m1['id'],
        title: m1['title'],
        category: m1['category'],
        amount: m1['amount'],
        date: m1['date'],
        status: m1['status'],
        time: m1['time']);
  }
}
