class Gamedata {
  int? id;
  String title;
  int price;
  String description;

  Gamedata({
    this.id,
    required this.title,
    required this.price,
    required this.description,
  });

//map => gamedata
  factory Gamedata.fromMap(Map<String, dynamic> map) {
    return Gamedata(
      id: map['id'] as int?,
      title: map['title'] as String,
      price: map['price'] as int,
      description: map['description'] as String,
    );
  }

//gamedata => map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
    };
  }
}
