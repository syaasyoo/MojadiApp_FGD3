class CartItem {
  String id, title, imagePath;
  double price;
  int qty;
  bool selected;
  CartItem(
      {required this.id,
      required this.title,
      required this.price,
      required this.qty,
      required this.selected,
      required this.imagePath});
}
