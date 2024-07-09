import 'package:fgd_2/providers/cart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context, listen: true);
    var formatter = NumberFormat.decimalPattern('id');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.separated(
          itemCount: cartData.totalItem,
          separatorBuilder: (context, index) => const SizedBox(
            height: 16,
          ),
          itemBuilder: (context, index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //checkbox
                Checkbox(
                  value: cartData.items.values.toList()[index].selected,
                  onChanged: (value) {
                    cartData.changeSelected(
                        cartData.items.values.toList()[index].id);
                  },
                ),
                //image
                Image(
                  image: NetworkImage(
                      cartData.items.values.toList()[index].imagePath),
                  height: 100,
                  width: 100,
                ),
                const SizedBox(
                  width: 16,
                ),
                //title etc
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //title
                      Text(
                        cartData.items.values.toList()[index].title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        maxLines: 2,
                      ),
                      //size
                      Text(
                        'Size: 14',
                        style: GoogleFonts.josefinSans(
                            fontWeight: FontWeight.w300),
                      ),
                      //price
                      Text(
                        'Rp ${cartData.items.values.toList()[index].price.toInt()}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      //qty
                      Row(
                        children: [
                          Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                color: Color(0xffE0E0E0),
                                borderRadius: BorderRadius.circular(10)),
                            child: IconButton(
                              onPressed: () {
                                cartData.addQty(
                                    cartData.items.values.toList()[index].id);
                              },
                              icon: const Icon(
                                Icons.add,
                                size: 20,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Text(
                            cartData.items.values
                                .toList()[index]
                                .qty
                                .toString(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                color: Color(0xffE0E0E0),
                                borderRadius: BorderRadius.circular(10)),
                            child: IconButton(
                              onPressed: () {
                                cartData.decreaseQty(
                                    cartData.items.values.toList()[index].id);
                              },
                              icon: const Icon(
                                Icons.remove,
                                size: 20,
                              ),
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Produk Berhasil Dihapus'),
                                  duration: Duration(seconds: 1),
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                              cartData.deleteItem(
                                  cartData.items.values.toList()[index].id);
                            },
                            icon: const Icon(
                              Icons.delete_outline,
                              size: 30,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
                //button delete
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(right: 20),
        height: 100,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 50,
            offset: Offset(0, 3),
          )
        ]),
        child: Row(
          children: [
            Checkbox(
              value: cartData.selectedAll,
              onChanged: (value) {
                cartData.selectAll();
              },
            ),
            Text('All'),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Total Price',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  formatter.format(cartData.selectedTotal),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xffBD8456),
                  ),
                )
              ],
            ),
            SizedBox(
              width: 14,
            ),
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(20),
                  backgroundColor: Color(0xffBD8456),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  'CHECKOUT',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ))
          ],
        ),
      ),
    );
  }
}
