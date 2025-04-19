class CartItem {
  final String id;
  final String productName;
  final String price;
  final String image;
  final int quantity;

  CartItem({
    required this.id,
    required this.productName,
    required this.price,
    required this.image,
    this.quantity = 1,
  });
} 