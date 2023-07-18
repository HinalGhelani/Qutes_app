import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qoutes_app/modal/quotes_Modals.dart';
import 'package:qoutes_app/utils/GlobalVar.dart';

class APIHelper {
  APIHelper._();

  static final APIHelper apiHelper = APIHelper._();

  Future<List<Quotes>?> fetchData() async {
    String uri = "https://api.api-ninjas.com/v1/quotes?category=";

    String api = uri + GlobalVar.endpoint;

    http.Response res = await http.get(
      Uri.parse(api),
      headers: {'X-Api-Key': '3eqJfi0fHICw9Azgd8pXDA==S3jZ4Xl0tKf7WdRW'},
    );

    if (res.statusCode == 200) {
      List decodedData = jsonDecode(res.body);
      print("${res.statusCode}");
      print(res.body);

      List<Quotes> data =
          decodedData.map((e) => Quotes.fromJson(json: e)).toList();
      return data;
    } else {
      return null;
    }
  }
}
