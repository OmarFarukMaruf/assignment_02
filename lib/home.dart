import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> products = [
    {
      "image": "assets/images/jacket.jpg",
      "name": "Jacket",
      "color": "Black",
      "size": "L",
      "price": 50,
      "count" : 1
    },
    {
      "image": "assets/images/tshirt.jpg",
      "name": "T-Shirt",
      "color": "Gray",
      "size": "L",
      "price": 30,
      "count" : 1
    },
    {
      "image": "assets/images/sports.jpg",
      "name": "Sport Dress",
      "color": "Black",
      "size": "M",
      "price": 43,
      "count" : 1
    },
  ];


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Show search functionality here
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Text("My Bag", style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
                itemCount: products.length,

                itemBuilder: (context, index) {
                  final product = products[index];
                  int count = product['count'] ?? 1;
                  var initialPrice = product['price'] / count;


                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 5,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Image.asset("${product['image']}", fit: BoxFit.cover,),
                        ),
                        Expanded(
                          flex: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("${product['name']}",
                                        style: const TextStyle(
                                            fontSize: 20, fontWeight: FontWeight.bold)),
                                    const Icon(Icons.more_vert)
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text("Color: ${product['color']}"),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text("Size: ${product['size']}"),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            if( products[index]['count'] > 1) {
                                              products[index]['count'] -= 1;
                                              setState(() {
                                                products[index]['price'] -= initialPrice;

                                              });
                                            }

                                          },
                                          style: ElevatedButton.styleFrom(
                                            shape: const CircleBorder(),
                                            padding: const EdgeInsets.all(20),
                                          ),
                                          child: const Icon(Icons.remove),
                                        ),
                                        const SizedBox(width: 10),
                                        Text("$count"),
                                        const SizedBox(width: 10),
                                        ElevatedButton(

                                          style: ElevatedButton.styleFrom(
                                            shape: const CircleBorder(),
                                            padding: const EdgeInsets.all(20),
                                          ),
                                          onPressed: () {
                                            products[index]['count'] += 1;
                                            if (products[index]['count'] == 5) {
                                              showDialog(
                                                context: context,
                                                builder: (_) => const ShowDialogue(),
                                              );
                                            }
                                            setState(() {
                                              products[index]['price'] += initialPrice;
                                            });
                                          },
                                          child: const Icon(Icons.add),
                                        ),
                                      ],
                                    ),
                                    Text("\$${product['price'].toInt()}")
            
                                  ],
            
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(left: 25, right: 25), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Text("Total"), Text("\$123")],),),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(

                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Congratulations on your purchase!'),
                            duration: Duration(seconds: 3), // Adjust duration as needed
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        onPrimary: Colors.white,
                        padding: const EdgeInsets.all(15),
                      ), // Implement button functionality here
                      child: const Text('CHECK OUT'),

                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ShowDialogue extends StatelessWidget {
  const ShowDialogue({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text("Congratulations!", style: TextStyle(fontWeight: FontWeight.bold),)),
      content: const Text("You Have added \n5 \nproducts on your Bag"),
      actions: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              onPrimary: Colors.white,

              padding: const EdgeInsets.all(15),
            ), // Implement button functionality here
            child: const Text('Okay'),

          ),
        ),
      ],
    );
  }
}

