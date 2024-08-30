import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart ' as http;
import 'package:db_miner/modal/quote_modal.dart';
import 'package:get/get.dart';


class QuotesController extends GetxController {
  RxList<QuoteModal> quotes = <QuoteModal>[].obs;
  RxList<QuoteModal> favoriteQuote = <QuoteModal>[].obs;
  Set<String> categories = {};
  RxString errorMessage = ''.obs;
  RxBool changeToggle = false.obs;
  RxInt selectedPage = 0.obs;
  GlobalKey imgKey = GlobalKey();

  var selectColor = Colors.black.obs;
  var selectedFontFamily = 'Roboto'.obs;
  var backgroundImage = ''.obs;
  var likedQuotes = <int>{}.obs;

  void updateColor(Color color) {
    selectColor.value = color;
  }

  void updateFontFamily(String fontFamily) {
    selectedFontFamily.value = fontFamily;
  }

  void updateBackgroundImage(String imagePath) {
    backgroundImage.value = imagePath;
  }

  void toggleLike(int index) {
    if (likedQuotes.contains(index)) {
      likedQuotes.remove(index);
    } else {
      likedQuotes.add(index);
    }
  }

  @override
  onInit() {
    super.onInit();
    fetchQuoteData();
  }

  Future<void> fetchQuoteData() async {
    final response = await http.get(
      Uri.parse('https://sheetdb.io/api/v1/accmtecgjck1x'),
    );
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      for (var item in data) {
        if (item['cate'] != null) {
          categories.add(item['cate']);
        }
      }
      print('Unique Categories:== ${categories.toList()}');
      print('Total Categories: ${categories.length}');
      quotes.assignAll(
        data.map((dynamic item) => QuoteModal.fromJson(item)).toList(),
      );
    } else {
      errorMessage('Unable to Load Quotes');
    }
  }
}
