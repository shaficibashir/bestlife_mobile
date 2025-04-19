class Product {
  final String id;
  final String productName;
  final String productPrice;
  final String brandImg;

  Product({
    required this.id,
    required this.productName,
    required this.productPrice,
    required this.brandImg,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id']?.toString() ?? '',
      productName: json['product_name']?.toString() ?? '',
      productPrice: json['product_price']?.toString() ?? '0',
      brandImg: json['brand_img']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_name': productName,
      'product_price': productPrice,
      'brand_img': brandImg,
    };
  }
} 