// models/coffe_model.dart
class CoffeModel {
  final String id;
  final String name;
  final String image;
  final String price;
  final String? short;

  CoffeModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    this.short,
  });
}
