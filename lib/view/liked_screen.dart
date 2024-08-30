import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_screen.dart';

class LikedQuotesScreen extends StatelessWidget {
  const LikedQuotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffff605f),
        centerTitle: true,
        title: const Text(
          'Liked Quotes',
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.w500),
        ),
      ),
      body: Obx(() {
        final likedQuotesIndices = quotesController.likedQuotes.toList();
        if (likedQuotesIndices.isEmpty) {
          return const Center(child: Text('No liked quotes'));
        }
        return ListView.builder(
          itemCount: likedQuotesIndices.length,
          itemBuilder: (context, index) {
            final quoteIndex = likedQuotesIndices[index];
            final quote = quotesController.quotes[quoteIndex];
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8.0),
                    Text(
                      quote.quote,
                      style: const TextStyle(fontSize: 22, color: Colors.black),
                    ),
                    const SizedBox(height: 8.0),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        '- ${quote.author}',
                        style: const TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
