import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_brands_ui/database/db.dart';
import 'package:flutter_brands_ui/models/nike_brands.dart';
import 'dart:math' as math;

class NewNikeBrands extends StatefulWidget {
  const NewNikeBrands({super.key});

  @override
  State<NewNikeBrands> createState() => _NewNikeBrandsState();
}

class _NewNikeBrandsState extends State<NewNikeBrands> {
  MyDB myDb = MyDB();

  @override
  void initState() {
    myDb.open();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: nikeBrandsList.length,
      itemBuilder: (context, index) {
        final nikeBrand = nikeBrandsList[index];
        return Stack(
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(right: 25),
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width * 0.55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: nikeBrand.background,
                ),
                padding: const EdgeInsets.all(15),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Nike'.toUpperCase(),
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                              const Icon(
                                Icons.favorite_outline,
                                color: Colors.white,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            nikeBrand.name.toUpperCase(),
                            style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            '\$${nikeBrand.price}',
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          onTap: () {
                            var scaffoldMessenger =
                                ScaffoldMessenger.of(context);

                            myDb.db!.rawInsert(
                                'INSERT INTO myBrands (image, name, price) VALUES (?, ?, ?)',
                                [
                                  nikeBrand.image,
                                  nikeBrand.name,
                                  nikeBrand.price
                                ]);

                            // pop up message
                            scaffoldMessenger.showSnackBar(
                              const SnackBar(
                                  backgroundColor: Colors.pink,
                                  content: Text('New Brand added to the Cart')),
                            );
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.shopping_cart_outlined,
                              color: nikeBrand.background,
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
            Positioned(
              bottom: 70,
              left: -25,
              child: Transform.rotate(
                angle: -math.pi / 8,
                child: Image.asset(
                  'assets/${nikeBrand.image}',
                  height: MediaQuery.of(context).size.height * 0.22,
                  width: MediaQuery.of(context).size.width * 0.7,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
