
class RestaurantModel {
  final int id;
  final String name;
  final String cuisine;

  RestaurantModel(
    {required this.id, 
    required this.name, 
    required this.cuisine});

  factory RestaurantModel.fromJson(Map<String, dynamic> json) {
    return RestaurantModel(
      id: json['id'],
      name: json['name'],
      cuisine: json['cuisine'],);
  }

}