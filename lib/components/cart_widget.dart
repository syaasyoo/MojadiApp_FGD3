import 'package:fgd_2/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class CartWidget extends StatelessWidget {
  const CartWidget({super.key, required this.qty});
  final String qty;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: badges.Badge(
        badgeStyle: const badges.BadgeStyle(
            padding: EdgeInsets.symmetric(
              horizontal: 5,
            ),
            badgeColor: Color(0xffFF7622)),
        badgeContent: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Text(
            qty,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CartScreen(),
                ));
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Icon(
              Icons.shopping_cart_outlined,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}
