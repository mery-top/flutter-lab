import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Product {
  final String name;
  final double price;
  final String description;

  Product({required this.name, required this.price, required this.description});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Online Shop',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Product> products = [
    Product(name: "Laptop", price: 800, description: "High performance laptop"),
    Product(name: "Phone", price: 500, description: "Latest smartphone"),
    Product(name: "Headphones", price: 100, description: "Noise cancelling"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Online Shop"),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartScreen(),
                ),
              );
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text(products[index].name),
              subtitle: Text("\$${products[index].price}"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProductDetailScreen(product: products[index]),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(product.description),
            SizedBox(height: 10),
            Text("Price: \$${product.price}",
                style: TextStyle(fontSize: 18, color: Colors.green)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Cart.addItem(product);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Added to cart")),
                );
              },
              child: Text("Add to Cart"),
            )
          ],
        ),
      ),
    );
  }
}

class Cart {
  static List<Product> items = [];

  static void addItem(Product product) {
    items.add(product);
  }

  static double totalPrice() {
    return items.fold(0, (sum, item) => sum + item.price);
  }
}

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Shopping Cart")),
      body: Cart.items.isEmpty
          ? Center(child: Text("Cart is empty"))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: Cart.items.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(Cart.items[index].name),
                        subtitle:
                            Text("\$${Cart.items[index].price.toString()}"),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "Total: \$${Cart.totalPrice()}",
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
    );
  }
}