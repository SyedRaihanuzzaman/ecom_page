class EcomModel {
  String? id;
  String? name;
  String? image;
  double? price;
  int quantity = 1;
  String? details;

  EcomModel({this.id, this.name, this.image, this.price, this.details});
}

List<EcomModel> products = [
  EcomModel(
    id: "1",
    name: "T-Shirt",
    image: "images/tshirtimage.webp",
    price: 500,
    details: "Comfortable cotton T-shirt perfect for daily wear.",
  ),
  EcomModel(
    id: "2",
    name: "Jeans",
    image: "images/jeansimage.jpeg",
    price: 1200,
    details: "Stylish slim-fit denim jeans that are durable and comfortable.",
  ),
  EcomModel(
    id: "3",
    name: "Sneakers",
    image: "images/sneakersimage.webp",
    price: 2500,
    details: "Lightweight running shoes perfect for sports and casual use.",
  ),
  EcomModel(
    id: "4",
    name: "Wrist Watch",
    image: "images/wristwatch.webp",
    price: 1800,
    details:
        "Elegant analog wristwatch with a water-resistant stainless steel body.",
  ),
  EcomModel(
    id: "5",
    name: "Backpack",
    image: "images/backpackimage.webp",
    price: 900,
    details: "Spacious and stylish backpack ideal for school or travel.",
  ),
  EcomModel(
    id: "6",
    name: "Headphones",
    image: "images/headphoneimage.jpeg",
    price: 1500,
    details: "High-quality stereo sound with comfortable cushioned ear pads.",
  ),
  EcomModel(
    id: "7",
    name: "Smartphone Case",
    image: "images/smartphonecaseimage.webp",
    price: 300,
    details: "Protective silicone phone case with slim design and good grip.",
  ),
  EcomModel(
    id: "8",
    name: "Sunglasses",
    image: "images/sunglassimage.webp",
    price: 700,
    details: "UV-protected stylish sunglasses perfect for sunny outdoor days.",
  ),
  EcomModel(
    id: "9",
    name: "Wallet",
    image: "images/walletimage.webp",
    price: 600,
    details: "Leather bi-fold wallet with a compact and durable design.",
  ),
  EcomModel(
    id: "10",
    name: "Bluetooth Speaker",
    image: "images/blutoothspeakerimage.webp",
    price: 2200,
    details:
        "Portable wireless speaker that delivers deep bass and clear sound.",
  ),
];
