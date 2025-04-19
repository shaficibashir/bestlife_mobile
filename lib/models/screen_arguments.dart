class ProductDetailArguments {
  final String id;
  final String title;
  final String image;
  final String price;
  final String oldPrice;
  final String review;
  final List<Map<String, String>>? images;

  ProductDetailArguments({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.oldPrice,
    required this.review,
    this.images,
  });
} 