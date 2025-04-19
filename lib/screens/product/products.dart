import 'package:lookme/components/bottomsheet/Gender_sheet.dart';
import 'package:lookme/components/product/product_card.dart';
import 'package:lookme/components/product/product_card_list.dart';
import 'package:lookme/screens/home/home.dart';
import 'package:lookme/utils/constants/colors.dart';
import 'package:lookme/utils/constants/images.dart';
import 'package:lookme/utils/constants/sizes.dart';
import 'package:lookme/utils/constants/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lookme/components/bottomsheet/filter_sheet.dart';
import 'package:lookme/components/bottomsheet/short_by.dart';
import 'package:get/get.dart';
import '../../controllers/product_controller.dart';
import '../../controllers/category_controller.dart';
// import 'package:lookme/components/category/category_item.dart';


class CategoryItems {
  String title;
  CategoryItems({required this.title});
}

class Products extends StatefulWidget {

  const Products({ super.key });

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  final ProductController productController = Get.find();
  final CategoryController categoryController = Get.find();

  String _productView = "grid";

  @override
  Widget build(BuildContext context){
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
              titleSpacing: 0,
              title: TextField(
                decoration: InputDecoration(
                  hintText: 'Search Products',
                  filled: true,
                  fillColor: Theme.of(context).canvasColor,
                  contentPadding: const EdgeInsets.only(left: 30,right: 20),
                  prefixIcon: Icon(Icons.search_outlined, size: 24, color: Theme.of(context).textTheme.titleMedium?.color,),
                  hintStyle: Theme.of(context).textTheme.titleMedium?.merge(TextStyle(fontWeight: FontWeight.w500, color:Theme.of(context).brightness == Brightness.dark ? IKColors.card.withOpacity(0.6) : IKColors.title.withOpacity(0.6))),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.circular(0),),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide.none,borderRadius: BorderRadius.circular(0),),
                  
                ),
                style: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(fontWeight: FontWeight.w400)),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _productView = (_productView == 'list') ? 'grid' : 'list';
                    });
                  },
                  iconSize: 28,
                  // ignore: deprecated_member_use
                  icon: SvgPicture.string((_productView == 'list') ? IKSvg.grid : IKSvg.list, color: Theme.of(context).textTheme.titleMedium?.color),
                ),
                Stack(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/cart');
                      }, 
                      iconSize: 28,
                      // ignore: deprecated_member_use
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
      body: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: IKSizes.container
          ),
          child: Column(
            children: [
              Container(
                color: Theme.of(context).cardColor,
                child: Obx(() {
             if (categoryController.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: categoryController.categoryList.map((category) {
                        return GestureDetector(
                          onTap: () {
                            categoryController.selectedCategory.value = category.categoryName;
                            // You can add category filtering logic here
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            margin: EdgeInsets.only(right: 10),
                            color: categoryController.selectedCategory.value == category.categoryName
                                ? Theme.of(context).textTheme.titleMedium?.color
                                : Theme.of(context).canvasColor,
                            child: Text(
                              category.categoryName,
                              style: Theme.of(context).textTheme.titleMedium?.merge(
                                TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: categoryController.selectedCategory.value == category.categoryName
                                      ? Theme.of(context).cardColor
                                      : Theme.of(context).textTheme.titleMedium?.color
                                )
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Obx(() {
                        if (productController.isLoading.value) {
                          return Center(child: CircularProgressIndicator());
                        }

                        return Wrap(
                          children: productController.productList.map((product) {
                            return SizedBox(
                              width: _productView == "list" 
                                  ? null 
                                  : MediaQuery.of(context).size.width > IKSizes.container 
                                      ? IKSizes.container / 3
                                      : (MediaQuery.of(context).size.width - 20) / 2,
                              child: _productView == "list"
                                  ? Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            width: 1,
                                            color: Theme.of(context).dividerColor
                                          )
                                        )
                                      ),
                                      padding: const EdgeInsets.all(15),
                                      child: ProductCardList(
                                        id: product.id,
                                        title: product.productName,
                                        price: product.productPrice,
                                        oldPrice: product.productPrice, // Add to model if needed
                                        image: "http://192.168.100.7/bestlife-main/public/assets/imgs/product_image/${product.brandImg}",
                                        offer: "0% Off", // Add to model if needed
                                        review: "(0 Review)" // Add to model if needed
                                      ),
                                    )
                                  : ProductCard(
                                      id: product.id,
                                      title: product.productName,
                                      image: "http://192.168.100.7/bestlife-main/public/assets/imgs/product_image/${product.brandImg}",
                                      price: product.productPrice,
                                      addCartBtn: true,
                                    ),
                            );
                          }).toList(),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              // Container(
              //   padding: EdgeInsets.symmetric(vertical: 10),
              //   decoration: BoxDecoration(
              //     border: Border(top: BorderSide(width: 1,color: Theme.of(context).canvasColor)) 
              //   ),
              //   child: Row(
              //     children: [
              //       Expanded(
              //         child: GestureDetector(
              //           onTap: (){ 
              //             showModalBottomSheet<void>(
              //               context: context,
              //               builder: (BuildContext context) {
              //                 return const GenderSheet();
              //               },
              //             );
              //           },
              //           child : Container(
              //             padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 9),
              //             decoration: BoxDecoration(
              //               border: Border(right: BorderSide(width: 1,color: Theme.of(context).canvasColor)) 
              //             ),
              //             child: Row(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               children: [
              //                 SvgPicture.string(
              //                   IKSvg.user,
              //                   color: Theme.of(context).textTheme.titleMedium?.color,
              //                 ),
              //                 const SizedBox(
              //                   width: 5,
              //                 ),
              //                 Text('GENDER',style: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(fontSize: 15,fontWeight: FontWeight.w500)))
              //               ],
              //             ),
              //           ),
              //         ),
              //       ),
              //       Expanded(
              //         child: GestureDetector(
              //           onTap: (){ 
              //             showModalBottomSheet<void>(
              //               context: context,
              //               builder: (BuildContext context) {
              //                 return const ShortBy();
              //               },
              //             );
              //           },
              //           child : Container(
              //             padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 9),
              //             decoration: BoxDecoration(
              //               border: Border(right: BorderSide(width: 1,color: Theme.of(context).canvasColor)) 
              //             ),
              //             child: Row(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               children: [
              //                 const Icon(Icons.arrow_upward_outlined),
              //                 const SizedBox(
              //                   width: 5,
              //                 ),
              //                 Text('SORT',style: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(fontSize: 15,fontWeight: FontWeight.w400)))
              //               ],
              //             ),
              //           ),
              //         ),
              //       ),
              //       Expanded(
              //         child: GestureDetector(
              //           onTap: (){ 
              //             showModalBottomSheet<void>(
              //               context: context,
              //               builder: (BuildContext context) {
              //                 return const FilterSheet();
              //               },
              //             );
              //           },
              //           child : Container(
              //             padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 9),
              //             child: Row(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               children: [
              //                 const Icon(Icons.filter_alt_outlined),
              //                 const SizedBox(
              //                   width: 5,
              //                 ),
              //                 Text('FILTER',style: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(fontSize: 15,fontWeight: FontWeight.w400)))
              //               ],
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}