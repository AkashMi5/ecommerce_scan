class Json {
  String status;
  Data d;

  Json({this.status, this.d});

  factory Json.fromJson(Map<String, dynamic> json) {
    return new Json(status: json['status'], d: Data.fromJson(json['data']));
  }
}

class Data {
  int id;
  int userid;
  Array array;
  int amount;
  int vat;
  int total;

  Data({this.id, this.userid, this.array, this.amount, this.vat, this.total});

  factory Data.fromJson(Map<String, dynamic> json) {
    return new Data(
      id: json['id'],
      userid: json['userid'],
      array: Array.fromJson(json['array']),
      amount: json['amount'],
      vat: json['vat'],
      total: json['total'],
    );
  }
}

class Array {
  String name;
  int price;
  int quantity;

  Array({this.name, this.price, this.quantity});

  factory Array.fromJson(Map<String, dynamic> json) {
    return new Array(
      name: json['name'],
      price: json['price'],
      quantity: json['quantity'],
    );
  }
}
