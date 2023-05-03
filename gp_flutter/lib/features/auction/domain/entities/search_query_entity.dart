class SearchQueryEntity {
  final String category;
  final String minPrice;
  final String maxPrice;
  final String name;

  SearchQueryEntity({
    this.name = '',
    this.category = '',
    this.minPrice = '',
    this.maxPrice = '',
  });
}
