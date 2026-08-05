class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final double shippingCost;
  final String category;
  final String imageUrl;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.shippingCost,
    required this.category,
    required this.imageUrl,
  });
}
