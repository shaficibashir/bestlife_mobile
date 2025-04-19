import 'package:lookme/utils/constants/colors.dart';
import 'package:lookme/utils/constants/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lookme/controllers/cart_controller.dart';
import 'package:lookme/models/product.dart';
import 'package:lookme/models/screen_arguments.dart';

class ScreenArguments {
  final dynamic id;

  ScreenArguments(this.id);
}

class ProductCard extends StatefulWidget {

  final String? category;
  final String title;
  final String image;
  final String price;
  final String? oldPrice;
  final String? review;
 
  final dynamic id;
  final dynamic addCartBtn;
  final dynamic wishlistRemovebtn;
  final String? inWishlist;
  final Function()? removePress;

  const ProductCard({super.key, 
    this.category,
    required this.title,
    required this.image,
    required this.price,
    this.oldPrice,
    this.review,
  
    this.id,
    this.addCartBtn,
    this.wishlistRemovebtn,
    this.inWishlist,
    this.removePress,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {

  late dynamic _isWishlist;
  final cartController = Get.find<CartController>();

  @override
  void initState(){
    super.initState();
    _isWishlist = widget.inWishlist == '1' ? true : false;
  }

  @override
  Widget build(BuildContext context){

    print(widget.image);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/product_detail',
          arguments: ProductDetailArguments(
            id: widget.id.toString(),
            title: widget.title,
            image: widget.image,
            price: widget.price,
            oldPrice: widget.oldPrice ?? widget.price,
            review: widget.review ?? '(0 Review)',
            images: null, // Add if you have images data
          ),
        );
      },
      child: Container(
        color: Theme.of(context).cardColor,
        margin: EdgeInsets.only(left: 5, right: 5, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Stack(
              children: [  
                AspectRatio(
                  aspectRatio: 1 / 1.6,
                  child: Image(
                    image: NetworkImage(widget.image),
                    fit: BoxFit.cover, // use this
                  ),
                ),
                if(widget.addCartBtn != null)
                Positioned(
                  left: 10,
                  right: 10,
                  bottom: 10,
                  child:GestureDetector(
                    onTap: () {
                      try {
                        final product = Product(
                          id: widget.id ?? '',
                          productName: widget.title ?? '',
                          productPrice: widget.price ?? '0',
                          brandImg: widget.image.split('/').last ?? '',
                        );
                        Get.find<CartController>().addToCart(product);
                      } catch (e) {
                        print('Error adding to cart: $e');
                        Get.snackbar(
                          'Error',
                          'Could not add item to cart',
                          snackPosition: SnackPosition.TOP,
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      margin: const EdgeInsets.only(top: 8.0,bottom: 4.0),
                      decoration: BoxDecoration(
                        color: IKColors.card,
                        borderRadius: BorderRadius.circular(0)
                      ),
                      child: Text('Add To Cart',textAlign: TextAlign.center,style: Theme.of(context).textTheme.titleMedium?.merge(TextStyle(color: IKColors.title))),
                    ),
                  )
                ),
                Positioned(
                  left: 5,
                  top: 5,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        _isWishlist = !_isWishlist;
                      });
                    }, 
                    iconSize: 20,
                    icon: SvgPicture.string(
                      IKSvg.heart,
                      width: 16,
                      height: 16,
                      // ignore: deprecated_member_use
                      color: _isWishlist ? IKColors.danger : IKColors.title.withOpacity(0.3),
                    ), 
                  ),
                ),
                if(widget.wishlistRemovebtn != null )
                Positioned(
                  right: 10,
                  top: 5,
                  child:GestureDetector(
                    onTap: () {
                      cartController.removeFromCart(widget.id.toString());
                    },
                    child: Container(
                      height: 38,
                      width: 38,
                      // padding: const EdgeInsets.all(5.0),
                      margin: const EdgeInsets.only(top: 8.0,bottom: 4.0),
                      decoration: BoxDecoration(
                        color: IKColors.card,
                        borderRadius: BorderRadius.circular(0)
                      ),
                      child:const Icon(
                        Icons.close,
                        size: 20,
                        color: IKColors.primary,
                      ),
                    ),
                  )
                ),
              ]
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15,top: 12,bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if(widget.category != null)
                    Text(widget.category!, style: Theme.of(context).textTheme.titleSmall?.merge(const TextStyle(color: IKColors.primary))),
                  const SizedBox(height: 3),
                  Text(widget.title,maxLines: 2,overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.titleLarge?.merge(TextStyle(fontSize: 14))),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text('\$${widget.price}',style: Theme.of(context).textTheme.titleLarge?.merge(TextStyle(fontSize: 16))),
                      const SizedBox(width: 6),
                      // Text('\$${widget.oldPrice}',style: Theme.of(context).textTheme.bodySmall?.merge(TextStyle(decoration: TextDecoration.lineThrough,fontWeight: FontWeight.w300,color:Theme.of(context).brightness == Brightness.dark ? Color.fromRGBO(255, 255, 255, 0.7) :  Color.fromARGB(255, 70, 70, 70) ))),
                      const SizedBox(width: 6),
                    
                      // Text(widget.review, style: Theme.of(context).textTheme.bodySmall?.merge(TextStyle(fontWeight: FontWeight.w300,fontSize: 8,  color:Theme.of(context).brightness == Brightness.dark ? Color.fromRGBO(255, 255, 255, 50) : Color.fromRGBO(0, 0, 0, 50) )),),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}