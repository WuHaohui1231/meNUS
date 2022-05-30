class CartModel {
  int? id;
  String? name;
  int? price;
  String? img;
  int? quantity;
  bool? ifExist;
  String? time;

  CartModel({
    this.id,
    this.name,
    this.price,
    this.img,
    this.quantity,
    this.ifExist,
    this.time,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    img = json['img'];
    quantity = json['quantity'];
    ifExist = json['ifExist'];
    time = json['time'];
  }
}
