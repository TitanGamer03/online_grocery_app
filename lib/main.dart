import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_screen.dart';

void main() {
  runApp(MyApp());
}

class Product {
  final String name;
  final int price;
  final String image; // Image path for assets
  int quantity;

  Product({
    required this.name,
    required this.price,
    required this.image,
    this.quantity = 0,
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: Consumer<CartModel>(
        builder: (context, cart, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: cart.isDarkTheme ? ThemeData.dark() : ThemeData(
              primarySwatch: Colors.green,
              scaffoldBackgroundColor: Colors.grey[200],
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.green,
                elevation: 0,
                titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            home: HomeScreen(),
          );
        },
      ),
    );
  }
}


class CartModel extends ChangeNotifier {
  final List<Product> _items = [];
  final List<List<Product>> _orderHistory = [];
  bool _isDarkTheme = false;
  String username = "John Doe";
  String email = "johndoe@example.com";
  String phone = "123-456-7890";
  List<String> addresses = ["123 Main St, City", "456 Elm St, City"];

  List<Product> get items => _items;
  List<List<Product>> get orderHistory => _orderHistory;
  bool get isDarkTheme => _isDarkTheme;

  void add(Product product) {
    _items.add(product);
    notifyListeners();
  }

  void remove(Product product) {
    _items.remove(product);
    notifyListeners();
  }

  void clear() {
    if (_items.isNotEmpty) {
      _orderHistory.insert(0, List.from(_items)); // Add orders at the top
      _items.clear();
      notifyListeners();
    }
  }

  int get totalPrice => _items.fold(0, (total, current) => total + current.price);

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  void updateProfile(String newUsername, String newEmail, String newPhone) {
    username = newUsername;
    email = newEmail;
    phone = newPhone;
    notifyListeners();
  }

  int getProductQuantity(Product product) {
    return _items.where((item) => item.name == product.name).length;
  }

}


class OrderDetailsScreen extends StatelessWidget {
  final List<Product> order;

  OrderDetailsScreen({required this.order});

  @override
  Widget build(BuildContext context) {
    int totalCost = order.fold(0, (sum, item) => sum + item.price);
    return Scaffold(
      appBar: AppBar(title: Text("Order Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                children: order.map((product) => ListTile(
                  // leading: Image.asset(AssetImage(product.image) as String),
                  leading: Image.asset(product.image, fit: BoxFit.cover),
                  title: Text(product.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  trailing: Text("₹${product.price}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                )).toList(),
              ),
            ),
            Divider(),
            Align(
              alignment: Alignment.centerRight,
              child: Text("Total: ₹$totalCost", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final List<Product> products = [
    Product(name: "Apple", price: 30, image: "assets/images/Apple.jpeg"),
    Product(name: "Banana", price: 10, image: "assets/images/Banana.jpeg"),
    Product(name: "Carrot", price: 20, image: "assets/images/Carrot.jpeg"),
    Product(name: "Tomato", price: 25, image: "assets/images/Tomato.jpeg"),
    Product(name: "Potato", price: 15, image: "assets/images/Potato.jpeg"),
    Product(name: "Onion", price: 18, image: "assets/images/Onion.jpeg"),
    Product(name: "Milk", price: 50, image: "assets/images/Milk.jpeg"),
    Product(name: "Eggs", price: 60, image: "assets/images/Eggs.jpeg"),
    Product(name: "Bread", price: 40, image: "assets/images/Bread.jpeg"),
    Product(name: "Butter", price: 90, image: "assets/images/Butter.jpeg"),
    Product(name: "Cheese", price: 120, image: "assets/images/Cheese.jpeg"),
    Product(name: "Rice", price: 70, image: "assets/images/Rice.jpeg"),
    Product(name: "Flour", price: 45, image: "assets/images/Flour.jpeg"),
    Product(name: "Sugar", price: 35, image: "assets/images/Sugar.jpeg"),
    Product(name: "Salt", price: 20, image: "assets/images/Salt.jpeg"),
    Product(name: "Oil", price: 150, image: "assets/images/Oil.jpeg"),
    Product(name: "Tea", price: 80, image: "assets/images/Tea.jpeg"),
    Product(name: "Coffee", price: 100, image: "assets/images/Coffee.jpeg"),
    Product(name: "Lentils", price: 110, image: "assets/images/Lentils.jpeg"),
    Product(name: "Spinach", price: 30, image: "assets/images/Spinach.jpeg"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Grocery Store")),
      body: Consumer<CartModel>(
        builder: (context, cart, child) {
          return GridView.builder(
            padding: EdgeInsets.all(10),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 3 / 4,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        product.image,
                        fit: BoxFit.cover,
                        width: 80,
                        height: 80,
                      ),
                      SizedBox(height: 10),
                      Text(product.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text("₹${product.price}", style: TextStyle(fontSize: 16)),
                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove, color: Colors.white),
                              onPressed: () {
                                setState(() {
                                  cart.remove(product);
                                });
                              },
                            ),
                            Text("${cart.getProductQuantity(product)}",
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                            IconButton(
                              icon: Icon(Icons.add, color: Colors.white),
                              onPressed: () {
                                setState(() {
                                  cart.add(product);
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
