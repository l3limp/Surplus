import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProductDescription extends StatefulWidget {

  User? user = FirebaseAuth.instance.currentUser;
  final Function addToCart;
  var product = {};

  ProductDescription(this.addToCart, this.product);

  @override
  _ProductDescriptionState createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  void addItem() {
    final snackBar = SnackBar(content: Text('${widget.product['title']} successfully added to cart! :)'), duration: Duration(seconds: 2),);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    widget.addToCart(widget.product['id'], quantity);
    Navigator.of(context).pop();
  }

  double quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 24,
              ),
              Container(
                  height: 120,
                  width: 120,
                  child: Image.network(widget.product['image'])),
              SizedBox(
                height: 20,
              ),
              Text(
                "\$${widget.product['title']}",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "\$${widget.product['price']}",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
              ),
              Text(
                "In Stock",
                style: TextStyle(fontSize: 12.0, color: Colors.blueGrey),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
                child: Text(
                  "${widget.product['description']}",
                  style: TextStyle(
                    fontSize: 14.0,
                  ),
                ),
              ),
              SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (quantity != 1) {
                            setState(() {
                              quantity -= 1;
                            });
                          }
                        },
                        icon: Icon(Icons.remove),
                      ),
                      Text('$quantity'),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            quantity += 1;
                          });
                        },
                        icon: Icon(Icons.add),
                      )
                    ],
                  ),
                  Container(
                    child: Text('Total price: \$${widget.product['price']*quantity}'),
                  ),
                ],
              ),
              SizedBox(
                height: 18,
              ),
              GestureDetector(
                onTap: addItem,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.0),
                      color: Color(0xFFFFD814)),
                  height: 50.0,
                  child: Center(
                    child: Text(
                      "Add to Cart",
                      style: TextStyle(
                        fontSize: 17.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}