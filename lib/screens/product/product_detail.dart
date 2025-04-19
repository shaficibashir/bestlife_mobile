import 'package:lookme/components/product/product_card.dart';
import 'package:lookme/models/product.dart';
import 'package:lookme/models/screen_arguments.dart';
import 'package:lookme/screens/home/home.dart';
import 'package:lookme/utils/constants/colors.dart';
import 'package:lookme/utils/constants/sizes.dart';
import 'package:lookme/utils/constants/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../components/common/touch_spin.dart';
import 'package:get/get.dart';
import '../../controllers/cart_controller.dart';
import '../../controllers/product_images_controller.dart';


class ItemSizes {
  String title;
  ItemSizes({required this.title});
}

class ItemColor {
  Color color;
  ItemColor({required this.color});
}

class ProductDetail extends StatefulWidget {
  const ProductDetail({ super.key });

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {

  String selectedSize = "S";

  Color selectedColor = Color(0xFFCC0D39);
  
  List<ItemSizes> productSizes = [
    ItemSizes(title: "S"),
    ItemSizes(title: "M"),
    ItemSizes(title: "L"),
    ItemSizes(title: "XL"),
    ItemSizes(title: "2XL"),
  ];

  List<ItemColor> productColor = [
    ItemColor(color: Color(0xFFCC0D39)),
    ItemColor(color : Color(0xFF5F75C5)),
    ItemColor(color : Color(0xFFC58F5E)),
    ItemColor(color : Color(0xFF919191)),
    ItemColor(color : Color(0xFFA872B1)),
    ItemColor(color : Color(0xFF699156)),
  ];
  
  String? imagePath;
  late ProductDetailArguments args;
  final ProductImagesController productImagesController = Get.put(ProductImagesController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        imagePath = args.image;
      });
      productImagesController.fetchProductImages(args.id);
    });
  }

  void changeImage(String newImage) {
    setState(() {
      imagePath = newImage;
    });
  }

  @override
  Widget build(BuildContext context){
    args = ModalRoute.of(context)!.settings.arguments as ProductDetailArguments;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(IKSizes.container, IKSizes.headerHeight), 
        child: Container(
          alignment: Alignment.center,
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: IKSizes.container
            ),
            child: AppBar(
              leading: Builder(
                builder: (context) {
                  return IconButton(
                    icon:Icon(Icons.arrow_back_ios,size: 20),
                    iconSize: 28,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  );
                },
              ),
              title: Text('Product Details', style: Theme.of(context).textTheme.bodyLarge?.merge(TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
              titleSpacing: 5,
              centerTitle: true,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(1.0),
                child: Container(
                    color: IKColors.light,
                    height: 1.0,
                )
              ),
              actions: [
                Stack(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/cart');
                      }, 
                      iconSize: 28,
                      icon: SvgPicture.string(IKSvg.cart,height: 20,width: 20, color: Theme.of(context).textTheme.titleMedium?.color),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        height: 16,
                        width: 16,
                        decoration: BoxDecoration(
                          color: IKColors.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: const Text('14',style: TextStyle(color: IKColors.card,fontSize: 10)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: IKSizes.container,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        color: Theme.of(context).canvasColor,
                        constraints: const BoxConstraints(
                          minHeight: 174,
                          maxHeight: 500,
                        ),
                        child: Stack(
                          children: [
                            if (imagePath != null)
                              Image.network(
                                imagePath!,
                                fit: BoxFit.cover,
                                width: double.maxFinite,
                              ),
                            if (args.images != null)
                              Positioned(
                                left: 0,
                                bottom: 0,
                                top: 0,
                                child: Container(
                                  margin: EdgeInsets.all(15),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    reverse: true,
                                    child: Column(
                                      children: args.images!.map((item) {
                                        return GestureDetector(
                                          onTap: () => changeImage(item['src']!),
                                          child: Container(
                                            margin: EdgeInsets.only(bottom: 10),
                                            height: 70,
                                            width: 50,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                width: 2,
                                                color: Theme.of(context).cardColor
                                              ),
                                              borderRadius: BorderRadius.circular(0),
                                            ),
                                            child: AspectRatio(
                                              aspectRatio: 1/1,
                                              child: Image.network(
                                                item['src']!,
                                                fit: BoxFit.cover
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10, top: 15),
                        color: Theme.of(context).cardColor,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    args.title,
                                    style: Theme.of(context).textTheme.titleMedium?.merge(
                                      TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: IKColors.primary
                                      )
                                    ),
                                  )
                                ),
                                const Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Color(0xFFFFA048),
                                ),
                                const SizedBox(width: 5),
                                Text.rich(
                                  TextSpan(
                                    text: '4.5 ',
                                    style: Theme.of(context).textTheme.titleMedium,
                                    children: <InlineSpan>[
                                      TextSpan(
                                        text: args.review,
                                        style: TextStyle(fontWeight: FontWeight.w300)
                                      )
                                    ]
                                  )
                                )
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Price:',
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Text(
                                          '\$${args.price}',
                                          style: Theme.of(context).textTheme.headlineLarge?.merge(
                                            const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: IKColors.primary
                                            )
                                          )
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          '\$${args.oldPrice}',
                                          style: Theme.of(context).textTheme.titleMedium?.merge(
                                            TextStyle(
                                              decoration: TextDecoration.lineThrough,
                                              fontWeight: FontWeight.w300,
                                              fontSize: 15
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(width: 40,),
                                Column(
                                  children: [
                                      Text('Quantity:', style: Theme.of(context).textTheme.titleMedium,),
                                      const SizedBox(height: 10,),
                                      TouchSpin(
                                        count : '3'
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      Container(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text('Product Images:', style: Theme.of(context).textTheme.titleMedium),
                            const SizedBox(height: 10),
                            Obx(() {
                              if (productImagesController.isLoading.value) {
                                return Center(child: CircularProgressIndicator());
                              }

                              if (productImagesController.productImages.isEmpty) {
                                return Text('No additional images available');
                              }

                              return Container(
                                height: 100,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: productImagesController.productImages.length,
                                  itemBuilder: (context, index) {
                                    final imageUrl = "http://192.168.100.7/bestlife-main/public/assets/imgs/product_image/${productImagesController.productImages[index]}";
                                    return GestureDetector(
                                      onTap: () => changeImage(imageUrl),
                                      child: Container(
                                        margin: EdgeInsets.only(right: 10),
                                        width: 100,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 2,
                                            color: imagePath == imageUrl 
                                                ? Theme.of(context).primaryColor 
                                                : Theme.of(context).dividerColor,
                                          ),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(6),
                                          child: Image.network(
                                            imageUrl,
                                            fit: BoxFit.cover,
                                            loadingBuilder: (context, child, loadingProgress) {
                                              if (loadingProgress == null) return child;
                                              return Center(
                                                child: CircularProgressIndicator(
                                                  value: loadingProgress.expectedTotalBytes != null
                                                      ? loadingProgress.cumulativeBytesLoaded / 
                                                        loadingProgress.expectedTotalBytes!
                                                      : null,
                                                ),
                                              );
                                            },
                                            errorBuilder: (context, error, stackTrace) {
                                              return Center(
                                                child: Icon(Icons.error_outline),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                     
                    ],
                  ),
                )
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children:[
                      ElevatedButton(
                        onPressed: () {
                          final cartController = Get.find<CartController>();
                          final product = Product(
                            id: args.id,
                            productName: args.title,
                            productPrice: args.price,
                            brandImg: args.image.split('/').last,
                          );
                          cartController.addToCart(product);
                        }, 
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                          backgroundColor:Theme.of(context).textTheme.titleMedium?.color,
                          side: const BorderSide(color: Colors.white),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.shopping_cart_outlined, size: 18, color:Theme.of(context).cardColor,),
                            const SizedBox(width: 10,),
                            Text('Add To Cart', style: Theme.of(context).textTheme.titleMedium?.merge(TextStyle(color:Theme.of(context).cardColor)))
                          ],
                        ),
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}