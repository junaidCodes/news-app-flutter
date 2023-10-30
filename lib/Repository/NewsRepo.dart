import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/Models/bbc_healines_model.dart';

class NewsRepository {
  Future<bbcHeadLinesModel> fetchBbcNewsHeadlinesApi() async {
    String url =
        // 'https://newsapi.org/v2/top-headlines?sources=ary-news&apiKey=f6e24648e9cd46a29ccef0fe406d8a39';
        'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=f6e24648e9cd46a29ccef0fe406d8a39';

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      return bbcHeadLinesModel.fromJson(body);
    } else {
      throw Exception('facing error');
    }
  }
}
