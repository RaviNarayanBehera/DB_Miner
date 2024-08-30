import 'package:db_miner/controller/quote_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/globals.dart';
import 'liked_screen.dart';

QuotesController quotesController = Get.put(QuotesController());

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: const Color(0xffff605f),
          centerTitle: true,
          title: const Text(
            'Quotes App',
            style: TextStyle(
                color: Colors.black, fontSize: 25, fontWeight: FontWeight.w500),
          ),
        ),
        body: Obx(() {
          if (quotesController.errorMessage.isNotEmpty) {
            return Center(
                child: Text(
                  quotesController.errorMessage.value,
                  style: const TextStyle(color: Colors.white),
                ));
          }
          if (quotesController.quotes.isEmpty) {
            return const Center(child: Text('No quotes available'));
          }
          return ListView.builder(
            itemCount: quotesController.categories.length,
            itemBuilder: (context, index) {
              final isLiked = quotesController.likedQuotes.contains(index);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 230,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.red.shade200,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                        child: Text(
                          quotesController.quotes[index].quote,
                          style: const TextStyle(fontSize: 22, color: Colors.black),
                        ),
                      ),
                      Align(alignment : Alignment.bottomRight,child: Text('-'+quotesController.quotes[index].author,style: const TextStyle(fontSize: 20, color: Colors.black),)),
                      const SizedBox(height: 12,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.toNamed('/like');
                              quotesController.toggleLike(index);
                            },
                            icon: Icon(
                              isLiked ? Icons.favorite : Icons.favorite_border,
                              color: isLiked ? Colors.red : Colors.black,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white
                              ),
                              child: IconButton(onPressed: () {
                                selectedIndex = index;
                                Get.toNamed('/detail');
                              }, icon: const Icon(Icons.touch_app_outlined,size: 30,)),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );

        }));
  }
}



