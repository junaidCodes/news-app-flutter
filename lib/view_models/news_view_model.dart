import 'package:news_app/Models/bbc_healines_model.dart';
import 'package:news_app/Repository/NewsRepo.dart';

class NewsViewModel {
  final newsRep = NewsRepository();

  Future<bbcHeadLinesModel> fetchBbcNewsHeadlinesApi() async {
    final response = await newsRep.fetchBbcNewsHeadlinesApi();

    return response;
  }
}
