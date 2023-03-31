import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'brands_cart.dart';
import 'models/more_brands.dart';
import 'new_nike_brands.dart';

class BrandsHome extends StatefulWidget {
  const BrandsHome({super.key});

  @override
  State<BrandsHome> createState() => _BrandsHomeState();
}

class _BrandsHomeState extends State<BrandsHome> with TickerProviderStateMixin {
  late final TabController controller = TabController(length: 5, vsync: this);
  late final TabController nikeBrandController =
      TabController(length: 3, vsync: this);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey.shade200,
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Discover',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.search),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => const BrandsCart()),
                              );
                            },
                            child: const Icon(Icons.shopping_cart_outlined)),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    TabBar(
                      controller: controller,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey.shade400,
                      indicatorColor: Colors.transparent,
                      labelStyle: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      isScrollable: true,
                      tabs: ['Nike', 'Adidas', 'Jordan', 'Puma', 'Reebok']
                          .map((brands) => Text(brands))
                          .toList(),
                    ),
                    Expanded(
                      child: TabBarView(controller: controller, children: [
                        nikeBrands(),
                        const Center(
                          child: Text('Adidas'),
                        ),
                        const Center(
                          child: Text('Jordan'),
                        ),
                        const Center(
                          child: Text('Puma'),
                        ),
                        const Center(
                          child: Text('Reebok'),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'More',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Icon(Icons.arrow_forward),
                        ],
                      ),
                      Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(
                            width: 10,
                          ),
                          scrollDirection: Axis.horizontal,
                          itemCount: moreBrandsList.length,
                          itemBuilder: (context, index) {
                            final moreBrand = moreBrandsList[index];
                            return Card(
                              elevation: 4,
                              child: Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width * 0.5,
                                padding: const EdgeInsets.all(10),
                                child: Stack(children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Align(
                                        alignment: Alignment.topRight,
                                        child: Icon(
                                          Icons.favorite_outline,
                                          size: 26,
                                        ),
                                      ),
                                      Image.asset('assets/${moreBrand.image}'),
                                      Text(
                                        moreBrand.name,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        '\$${moreBrand.price}',
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                  RotatedBox(
                                    quarterTurns: 3,
                                    child: Container(
                                      height: 25,
                                      width: 80,
                                      color: Colors.pink,
                                      child: Center(
                                        child: Text(
                                          'New'.toUpperCase(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      )),
    );
  }

  Widget nikeBrands() => Row(
        children: [
          RotatedBox(
            quarterTurns: 3,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: TabBar(
                controller: nikeBrandController,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey.shade400,
                indicatorColor: Colors.transparent,
                labelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                isScrollable: true,
                tabs: ['New', 'Featured', 'Upcoming']
                    .map((brands) => Text(brands))
                    .toList(),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(controller: nikeBrandController, children: const [
              NewNikeBrands(),
              Center(
                child: Text('Featured'),
              ),
              Center(
                child: Text('Upcoming'),
              ),
            ]),
          ),
        ],
      );
}
