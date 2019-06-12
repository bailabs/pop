import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pop/models/choice.dart';

Future<List<Choice>> getMovieData({String chart}) async {
  List<Choice> movies = [];
  http.Response response = await http.get(
      'https://api.themoviedb.org/3/$chart?api_key=f7b9bed63a8511395ba832915415f2ce');
  if (response.statusCode == 200) {
    String data = response.body;
    var jsonData = jsonDecode(data);
    for (var res in jsonData['results']) {
      String title = res['title'] != null ? res['title'] : res['name'];
      movies.add(
        Choice(
          name: title,
          image: 'http://image.tmdb.org/t/p/w185/' + res['poster_path'],
          rank: res['popularity'] * -1,
        ),
      );
    }
  }
  return movies;
}
