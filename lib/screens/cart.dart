import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {

    var cartItemsList = ModalRoute.of(context)!.settings.arguments as Map;
    double totalPrice = 0;

    void calculateTotalAmount() {
      setState(() {
        int i = 0;
        while(i<cartItemsList['items'].length){
          totalPrice = totalPrice + (cartItemsList['items'][i].quantity)*(cartItemsList['items'][i].price);
          i = i + 1;
          print(totalPrice);
        }
      });
    }

    void removeItem(int index){
      setState(() {
        cartItemsList['items'].remove(cartItemsList['items'][index]);
        calculateTotalAmount();
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[700],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.builder(
                    itemCount: cartItemsList['items'].length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(4, 8, 0, 8),
                                child: Container(
                                  height: 80,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                      fit: BoxFit.contain,
                                      image: NetworkImage(cartItemsList['items'][index].image)
                                    )
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width/12,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(height: 16,),
                                      Container(
                                        width: MediaQuery.of(context).size.width/3,
                                        child: Text(
                                          '${cartItemsList['items'][index].title}',
                                          softWrap: true,
                                          style: TextStyle(
                                              fontSize: 22.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(width: MediaQuery.of(context).size.width/15,),
                                      IconButton(
                                          onPressed: () {
                                            removeItem(index);
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.redAccent,
                                            size: 30,
                                          ))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Quantity: ${cartItemsList['items'][index].quantity}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Price : \$${cartItemsList['items'][index].price}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    })),
          ),
          Positioned(
            bottom : 0.0,
            child: Container(
                height: 50.0,
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Text('Total Amount: \$$totalPrice',
                    style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),),
                )
            ),
          ),
        ],
      ),
    );
  }
}