class Category {
  final String id;
  final String categoryName;
  final String categoryNameAr;
  final String img;

  Category({
    required this.id,
    required this.categoryName,
    required this.categoryNameAr,
    required this.img,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? '',
      categoryName: json['category_name'] ?? '',
      categoryNameAr: json['category_name_ar'] ?? '',
      img: json['img'] ?? '',
    );
  }
} 