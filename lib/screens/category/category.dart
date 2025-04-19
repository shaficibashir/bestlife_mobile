import 'package:lookme/components/category/category_item.dart';
import 'package:lookme/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/images.dart';
import 'package:get/get.dart';
import 'package:lookme/controllers/category_controller.dart';

class Category extends StatelessWidget {

  Category({ super.key });

  final CategoryController categoryController = Get.find();

  @override
  Widget build(BuildContext context){
    return  Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(IKSizes.container, IKSizes.headerHeight), 
        child: Container(
          alignment: Alignment.center,
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: IKSizes.container
            ),
            child: AppBar(
              title: Text('Category', style: Theme.of(context).textTheme.bodyLarge?.merge(TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
              // titleSpacing: 5,
              actions: [
                IconButton(
                    icon: const Icon(Icons.search),
                    iconSize: 28,
                    onPressed: () {
                      Navigator.pushNamed(context, '/search_screen');
                    },
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Text(
                    'Choose Your Category',
                    style: Theme.of(context).textTheme.headlineMedium?.merge(TextStyle(height: 1.5))
                  ),
                ),
                Obx(() {
                  if (categoryController.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    child: Wrap(
                      children: categoryController.categoryList.map((category) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width > IKSizes.container ? 
                            (IKSizes.container - 20) / 3
                            :
                            (MediaQuery.of(context).size.width - 20) / 2,
                          child: GestureDetector(
                            onTap: () {
                              // Set selected category and navigate to products
                              categoryController.selectedCategory.value = category.categoryName;
                              Navigator.pushNamed(context, '/products');
                            },
                            child: Container(
                              color: IKColors.card,
                              margin: EdgeInsets.only(left: 8, right: 8, bottom: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Stack(
                                    children: [  
                                      AspectRatio(
                                        aspectRatio: 1 / 1.4,
                                        child: Image.network(
                                          'http://192.168.100.7/bestlife-main/public/assets/imgs/category/${category.img}',
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Container(
                                              color: Colors.grey[300],
                                              child: Center(
                                                child: Icon(Icons.error)
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      Positioned(
                                        left: 10,
                                        right: 10,
                                        bottom: 10,
                                        child: Container(
                                          padding: const EdgeInsets.all(10.0),
                                          margin: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                                          decoration: BoxDecoration(
                                            color: IKColors.card,
                                            borderRadius: BorderRadius.circular(0)
                                          ),
                                          child: Text(
                                            category.categoryName,
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context).textTheme.titleMedium?.merge(
                                              TextStyle(color: IKColors.title)
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]
                                  ),
                                ],
                              )
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }),
              ],
            ),
          )
        ),
      )
    );
  }
}