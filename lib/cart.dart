import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartModel>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Cart")),
      body: cart.items.isEmpty
          ? Center(child: Text("Your cart is empty!"))
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, index) {
                final item = cart.items[index];
                return ListTile(
                  leading: Image.asset(item.image),
                  title: Text(item.name),
                  subtitle: Text("₹${item.price}"),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_circle,
                    color: Colors.red,
                    ),
                    onPressed: () => cart.remove(item),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text("Checkout Successful"),
                    content: Text("Your order has been placed!"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          cart.clear();
                          Navigator.of(context).pop();
                        },
                        child: Text("OK"),
                      ),
                    ],
                  ),
                );
              },
              child: Text("Checkout"),
            ),
          ),
        ],
      ),
    );
  }
}