class Quotes {
  final String quote;
  final String author;
  final String category;

  Quotes({
    required this.quote,
    required this.author,
    required this.category,
  });

  factory Quotes.fromJson({required Map json}) {
    return Quotes(
      quote : json['quote'],
      author: json['author'],
      category: json['category']
    );
  }
}
