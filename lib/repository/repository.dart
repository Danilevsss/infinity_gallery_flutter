import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/gallery.dart';
import '../values/values.dart';

class Repository {
  static Repository? repo;

  static Repository getInstance() {
    repo ??= Repository();
    return repo!;
  }

  Future<List<Gallery>> nextPage(int page) async {
    final url = Uri.parse("$mainUrl/?client_id=$clientId&page=$page");
    final response = await http.get(url);
    return _parseGalleryResponse(response);
  }

  List<Gallery> _parseGalleryResponse(response) {
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final list = jsonDecode(body);
      List<Gallery> result = [];

      for (var i = 0; i < list.length; i++) {
        result.add(Gallery(list[i]["id"], Urls(list[i]["urls"]["regular"]),
            User(list[i]["user"]["name"]), false));
      }
      return result;
    } else {
      throw Exception("failed request");
    }
  }
}
