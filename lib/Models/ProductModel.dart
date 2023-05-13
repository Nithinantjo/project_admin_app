class ProductModel {
  late String? name;
  late String? amount;
  late String? price;
  late String? image;

  ProductModel({
    this.name, this.amount, this.price, this.image
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    amount = json["amount"];
    price = json["price"];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic> {};

    _data["name"] = name;
    _data["amount"] = amount;
    _data["price"] = price;
    _data["image"] = image;

    return _data;
  }
}