import 'package:flutter/material.dart';

import '../api/api.dart';
import 'addproductform.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool sear = true;
  List prods = [];

  void _removeProduct(int index) {
    APIService.removeprod(prods[index]['name']);
    setState(() {
      prods.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFFCFAF8),
        title: Container(
          height: 45,
          child: TextField(
            onSubmitted: (value) async{
              prods = await APIService.search(value);
              print(prods);
              setState(() {
                sear = false;
              });
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromARGB(255, 148, 146, 146),
              contentPadding: const EdgeInsets.all(0),
              prefixIcon: const Icon(Icons.search, color: Colors.black,),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide.none
              ),
              hintStyle: const TextStyle(
                fontSize: 14,
                color: Colors.black
              ),
              hintText: "Search items"
            ),
          ),
        ),
      ),
      body:sear? const Center(child: Text('Search Here'),) : GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        padding: EdgeInsets.all(16.0),
        children: List.generate(
          prods.length,
          (index) {
            return GestureDetector(
              onTap: () {
                // Navigate to product details page
              },
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Text(
                        prods[index]['name'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 50.0, vertical: 8.0),
                      height: 150.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8&w=1000&q=80'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Text(
                        'Rs. ${prods[index]['price']}',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    OutlinedButton(
                      onPressed: () {
                        _removeProduct(index);
                      },
                      child: Text(
                        'Remove',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProductAddForm()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
