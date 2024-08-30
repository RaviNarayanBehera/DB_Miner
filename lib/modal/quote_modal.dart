class QuoteModal {
  late String quote, author, cate, like;
  late int? id;

  QuoteModal({
    required this.quote,
    required this.author,
    required this.cate,
    required this.like,
    required this.id,
  });

  factory QuoteModal.fromJson(Map m1) {
    return QuoteModal(
      id: m1['id'],
      quote: m1['quote'],
      author: m1['author'],
      cate: m1['cate'],
      like: m1['like'],
    );
  }
}