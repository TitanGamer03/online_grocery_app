import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey[300],
                  child: Icon(Icons.person, size: 30, color: Colors.black54),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(cart.username, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Text(cart.email, style: TextStyle(fontSize: 14, color: Colors.grey)),
                    Text(cart.phone, style: TextStyle(fontSize: 14, color: Colors.grey)),
                  ],
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditProfileScreen()),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Divider(),
            ListTile(
              title: Text("View Order History"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrderHistoryScreen()),
                );
              },
            ),
            Divider(),
            ListTile(
              title: Text("Address"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddressPage()),
                );
              },
            ),
            Divider(),
            ListTile(
              title: Text("Offers"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OffersPage()),
                );
              },
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);
    _usernameController.text = cart.username;
    _emailController.text = cart.email;
    _phoneController.text = cart.phone;

    return Scaffold(
      appBar: AppBar(title: Text("Edit Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _usernameController, decoration: InputDecoration(labelText: "Username")),
            TextField(controller: _emailController, decoration: InputDecoration(labelText: "Email")),
            TextField(controller: _phoneController, decoration: InputDecoration(labelText: "Phone")),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                cart.updateProfile(
                  _usernameController.text,
                  _emailController.text,
                  _phoneController.text,
                );
                Navigator.pop(context);
              },
              child: Text("Save Changes"),
            ),
          ],
        ),
      ),
    );
  }
}


// Address and Offers page placeholders
class AddressPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Address")),
      body: Center(child: Text("Manage Your Addresses Here")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new address functionality
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class OffersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Offers")),
      body: Center(child: Text("Available Offers")),
    );
  }
}

class OrderHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartModel>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Order History")),
      body: ListView.builder(
        itemCount: cart.orderHistory.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text("Order ${index + 1}"),
              subtitle: Text("Items: ${cart.orderHistory[index].length}"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OrderDetailsScreen(order: cart.orderHistory[index])),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

