class ApiCall {
  static String baseURL =
      "https://newsdata.io/api/1/news?apikey=pub_43462e9b4f0e969c825e9e877db67bc565e7f&";

  static const int receiveTimeout = 15;
  static const int connectionTimeout = 15;
}

enum Endpoints {
  getNews(
      'country={country}&category={category}'),

  nextPage('country={country}&category={category}&page={page}');

  final String endpoint;
  const Endpoints(this.endpoint);
}
