import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_brands_ui/database/db.dart';
import 'dart:math' as math;

class BrandsCart extends StatefulWidget {
  const BrandsCart({super.key});

  @override
  State<BrandsCart> createState() => _BrandsCartState();
}

class _BrandsCartState extends State<BrandsCart> {
  MyDB myDB = MyDB();
  List<Map> cartList = [];

  @override
  void initState() {
    myDB.open();
    getBrandsList();
    super.initState();
  }

  getBrandsList() {
    Future.delayed(const Duration(seconds: 1), () async {
      cartList = await myDB.db!.rawQuery('SELECT * FROM myBrands');
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    num total = cartList.fold(0, (prev, value) => prev + value['price']);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back_sharp)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'My Bag',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Total ${cartList.length} items',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 10,
            child: ListView.builder(
              itemCount: cartList.length,
              itemBuilder: (context, index) {
                final cart = cartList[index];
                return Container(
                  height: MediaQuery.of(context).size.height * 0.18,
                  // color: Colors.yellow,
                  margin: const EdgeInsets.only(bottom: 4),
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          Center(
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.12,
                              width: MediaQuery.of(context).size.width * 0.28,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.grey.shade300,
                              ),
                            ),
                          ),
                          Transform.rotate(
                            angle: -math.pi / 8,
                            child: Image.asset(
                              'assets/${cart['image']}',
                              height: MediaQuery.of(context).size.height * 0.1,
                              width: MediaQuery.of(context).size.width * 0.32,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cart['name'].toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '\$${cart['price']}',
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 30,
                                    width: 35,
                                    color: Colors.grey.shade200,
                                    child: const Icon(Icons.remove),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text(
                                    '1',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    height: 30,
                                    width: 35,
                                    color: Colors.grey.shade200,
                                    child: const Icon(Icons.add),
                                  ),
                                ],
                              ),
                            ]),
                      ),
                      GestureDetector(
                        onTap: () {
                          var scaffoldMessenger = ScaffoldMessenger.of(context);

                          myDB.db!.rawDelete(
                              'DELETE FROM myBrands WHERE id = ?',
                              [cart['id']]);

                          // pop up message
                          scaffoldMessenger.showSnackBar(
                            const SnackBar(
                                backgroundColor: Colors.black,
                                content:
                                    Text('New Brand removed from the Cart')),
                          );
                          getBrandsList();
                        },
                        child: const CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.black,
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total'.toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '\$$total',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink),
                      child: Text(
                        'Next'.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
