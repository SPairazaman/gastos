class GastoModel {
  String title;
  double price;
  String dateTime;
  String type;

  GastoModel({
    required this.title,
    required this.price,
    required this.dateTime,
    required this.type,
  });

  factory GastoModel.fromDB(Map<String, dynamic> data) => GastoModel(
    title: data["title"],
    price: data["price"],
    dateTime: data["dateTime"],
    type: data["type"],
  );

  Map<String, dynamic> toDB() => {
    "title": title,
    "price": price,
    "dateTime": dateTime,
    "type": type,
  };
}