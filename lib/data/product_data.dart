class ProductData {
  final String name, description, image, id;
  final int price;

  ProductData(
      {required this.name,
      required this.description,
      required this.image,
      required this.price,
      required this.id});
}

List<ProductData> products = [
  ProductData(
    name: 'Signature Trilogy Whole Cake',
    description:
        'Kue cokelat premium yang kaya rasa cokelat dengan isian kacang almond dan hazelnut yang melimpah.',
    image: 'assets/trilogy.png',
    price: 444000,
    id: '1',
  ),
  ProductData(
    name: 'Signature Black Forest Piece Cake',
    description:
        'Black Forest klasik dengan kombinasi cream cokelat dan potongan black cherry kaya rasa ditambah topping buah cherry dan taburan cokelat serut.',
    image: 'assets/black_forest.png',
    price: 59000,
    id: '2',
  ),
  ProductData(
    name: 'Souffle Cheese Piece Cake',
    description:
        'Soufflé Cheese Piece Cake menggabungkan kelembutan soufflé dengan kelezatan keju yang khas, membentuk perpaduan yang sempurna antara rasa lembut dan kaya.',
    image: 'assets/cheese_piece.png',
    price: 59000,
    id: '3',
  ),
  ProductData(
    name: 'Signature Tiramisu Whole Cake',
    description:
        'Kue premium khas Italia dengan perpaduan pas antara espresso dan krim mascarpone cheese lembut ditambah taburan bubuk cocoa.',
    image: 'assets/tiramisu.png',
    price: 59000,
    id: '4',
  ),
  ProductData(
    name: 'Classic Red Velvet Cake',
    description:
        'Kue Red Velvet premium bergaya klasik yang lembut dengan lapisan creamcheese frosting spesial yang kaya rasa.',
    image: 'assets/red.png',
    price: 59000,
    id: '5',
  ),
  ProductData(
    name: 'Chantilly Choco Fresh Cream',
    description:
        'Kue cokelat chiffontender dari lapisan kue cokelat chiffon yang ringan dan lembut, dihiasi dengan krim segar yang lembut, dan dihiasi dengan taburan cokelat yang melimpah.',
    image: 'assets/choco.png',
    price: 59000,
    id: '6',
  ),
];
