import 'package:lookme/components/product/product_cart.dart';
import 'package:lookme/screens/home/home.dart';
import 'package:lookme/utils/constants/colors.dart';
import 'package:lookme/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/cart_controller.dart';

class Cart extends StatefulWidget {

  const Cart({ super.key });

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CartController cartController = Get.find();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(IKSizes.container, IKSizes.headerHeight), 
        child: Container(
          alignment: Alignment.center,
          child: Container(
            // margin: EdgeInsets.only(top: 60),
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
              titleSpacing: 0,
              title: Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('My Cart', style: Theme.of(context).textTheme.bodyLarge?.merge(TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                  Row(
                    children: [
                      Text('${cartController.cartItems.length}', style: Theme.of(context).textTheme.titleSmall?.merge(TextStyle(fontWeight: FontWeight.bold))),
                      const SizedBox(width: 5),
                      Text('items', style: Theme.of(context).textTheme.titleSmall?.merge(TextStyle(fontWeight: FontWeight.w300))),
                      const SizedBox(width: 4),
                      Text('*',style: Theme.of(context).textTheme.titleSmall?.merge(TextStyle( fontWeight: FontWeight.bold, ))),
                      const SizedBox(width: 4),
                      Text('Deliver to:',style: Theme.of(context).textTheme.titleSmall?.merge(TextStyle( fontWeight: FontWeight.w300, ))),
                      const SizedBox(width: 5),
                      Text('London',style: Theme.of(context).textTheme.titleSmall?.merge(TextStyle( fontWeight: FontWeight.bold, ))),
                    ],
                  )
                ],
              )),
              actions: <Widget>[
                Container(
                  color: Theme.of(context).canvasColor,
                  margin: EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
                  child:Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                            Navigator.pushNamed(context, '/delivery_address');
                        },
                        child: Text('Change',style: Theme.of(context).textTheme.titleMedium?.merge(TextStyle( fontWeight: FontWeight.w300, ))),
                      ),
                    ],
                  ),
                )
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(1.0),
                child: Container(
                    color: IKColors.light,
                    height: 1.0,
                )
              ),
            ),
          ),
        )
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: IKSizes.container,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Obx(() {
                  if (cartController.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (cartController.cartItems.isEmpty) {
                    return Center(
                      child: Text(
                        'Your cart is empty',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    );
                  }

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            border: Border(
                              bottom: BorderSide(
                                color: IKColors.border,
                                width: 1.0,
                              ),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text.rich(
                                TextSpan(
                                  text: 'Subtotal ',
                                  style: Theme.of(context).textTheme.titleMedium?.merge(
                                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w300)
                                  ),
                                  children: <InlineSpan>[
                                    TextSpan(
                                      text: '\$${cartController.totalAmount.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        color: IKColors.primary,
                                        fontWeight: FontWeight.bold
                                      )
                                    ),
                                  ]
                                )
                              ),
                              Row(
                                children: [
                                    const Icon(
                                      Icons.check_circle,
                                      size: 24,
                                      color: IKColors.success,
                                    ),
                                    const SizedBox(width: 4),
                                    Text('Your order is eligible for free Devivery', 
                                        style: Theme.of(context).textTheme.titleMedium?.merge(TextStyle(fontWeight: FontWeight.w500,)),
                                        textAlign: TextAlign.left,
                                        maxLines: 1,
                                    )
                                ],
                              )
                              // Image.asset(IKImages.giftBox,height: 45)
                            ],
                          ),
                        )
                        ,
                        Column(
                          children: cartController.cartItems.map((product) {
                            return Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 1,
                                    color: Theme.of(context).dividerColor
                                  )
                                )
                              ),
                              padding: const EdgeInsets.all(15),
                              child: ProductCart(
                                id: product.id,
                                title: product.productName,
                                price: product.productPrice,
                                oldPrice: product.productPrice,
                                image: "http://192.168.100.7/bestlife-main/public/assets/imgs/product_image/${product.brandImg}",
                                review: "(0 Review)",
                                count: "1",
                                removePress: () {
                                  cartController.removeFromCart(product.id);
                                },
                              ),
                            );
                          }).toList(),
                        ),
                      ]
                    ),
                  );
                }),
              ),
              Obx(() => Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  boxShadow: const <BoxShadow>[
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.1),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: cartController.cartItems.isEmpty ? null : () {
                    Navigator.pushNamed(context, '/delivery_address');
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                    backgroundColor: Theme.of(context).textTheme.titleMedium?.color,
                    side: const BorderSide(color: Colors.white),
                  ),
                  child: Text(
                    'Proceed to Buy (${cartController.cartItems.length} items)',
                    style: Theme.of(context).textTheme.titleMedium?.merge(
                      TextStyle(fontSize: 15, color: Theme.of(context).cardColor)
                    ),
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}