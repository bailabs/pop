import 'package:html/dom.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;
import 'package:pop/models/choice.dart';

Future<List<Choice>> getBillboardCharts({String chart}) async {
  double rank = 1;
  List<Choice> artists = [];
  http.Response response =
      await http.get('https://www.billboard.com/charts/$chart/');

  Document document = parser.parse(response.body);

  document.getElementsByClassName('chart-list-item').forEach((Element element) {
    String title = element
        .getElementsByClassName('chart-list-item__title-text')[0]
        .text
        .replaceAll("\n", "")
        .trim();
    String artist = element
        .getElementsByClassName('chart-list-item__artist')[0]
        .text
        .replaceAll("\n", "")
        .trim();

    if (artist == '') {
      artist = title;
    }

    String src = element
        .getElementsByClassName('chart-list-item__image-wrapper')[0]
        .getElementsByClassName('chart-list-item__image')[0]
        .attributes['data-srcset'];
    String image;
    if (src != null) {
      var arr = src.split(',');
      image = arr[arr.length - 1].split(" ")[1];
    } else {
      image = element
          .getElementsByClassName('chart-list-item__image-wrapper')[0]
          .getElementsByClassName('chart-list-item__image')[0]
          .attributes['data-src'];
    }

    artists.add(Choice(name: artist, image: image, rank: rank));

    rank++;
  });

  return artists;
}
