import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<CartModel>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Column(
        children: [
          SwitchListTile(
            title: Text("Dark Theme"),
            value: cart.isDarkTheme,
            onChanged: (bool value) {
              cart.toggleTheme();
            },
          ),
        ],
      ),
    );
  }
}