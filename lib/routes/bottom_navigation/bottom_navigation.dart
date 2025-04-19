// ignore_for_file: deprecated_member_use
import 'package:lookme/utils/constants/sizes.dart';
import 'package:lookme/utils/constants/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lookme/screens/cart/cart.dart';
import 'package:lookme/screens/category/category.dart';
import 'package:lookme/screens/home/home.dart';
import 'package:lookme/screens/profile/profile.dart';
import 'package:lookme/screens/wishlist/wishlist.dart';

final List<Map<String, String>> iconList = [
    {
      'id' : '0',
      'icon' : IKSvg.home,
    },
    // {
    //   'id' : '1',
    //   'icon' : IKSvg.wishlist,
    // },
    {
      'id' : '1',
      'icon' : IKSvg.cart,
    },
    {
      'id' : '2',
      'icon' : IKSvg.category,
    },
    {
      'id' : '3',
      'icon' : IKSvg.profile,
    },
];


class BottomNavigation extends StatefulWidget {
  const BottomNavigation({ super.key });

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {

  int _selectedIndex = 0;

  final List<Widget> _pages = <Widget>[
    const Home(),
    // Wishlist(),
    const Cart(),
    Category(),
    const Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:  IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width > IKSizes.container ? 
           (MediaQuery.of(context).size.width - IKSizes.container) / 2
            :
            0
           ),
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Color.fromARGB(27, 2, 81, 53),
              blurRadius: 30,
              offset: Offset(0, -8)
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: iconList.map((item){
            return IconButton(
              onPressed: (){
                _onItemTapped(int.parse(item['id']!));
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(12),
                backgroundColor: _selectedIndex == int.parse(item['id']!) ? Theme.of(context).textTheme.titleMedium?.color : Colors.transparent,
              ), 
              icon: SvgPicture.string(
                item['icon']!,
                width: 20,
                height: 20,
                color: _selectedIndex == int.parse(item['id']!) ? Theme.of(context).cardColor : Theme.of(context).textTheme.titleMedium?.color,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

