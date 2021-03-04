import 'dart:convert';
import 'dart:io';
import 'package:blocpatten/models/post_model.dart';
import 'package:http/http.dart' as http;

abstract class HttpRepository {
  Future<List<PostModel>> getData();
}

class SampleHttpRepository implements HttpRepository {
  var jsonPlaceHolderUrl = "https://jsonplaceholder.typicode.com/posts";
  @override
  Future<List<PostModel>> getData() async {
    final response = await http.get(jsonPlaceHolderUrl);

    switch (response.statusCode) {
      case HttpStatus.ok:
        final jsonBody = jsonDecode(response.body) as List;
        return jsonBody.map((e) => PostModel.fromJson(e)).toList();
      default:
        throw NetworkError(response.statusCode.toString(), response.body);
    }
  }
}

class NetworkError implements Exception {
  final String statusCode;
  final String message;

  NetworkError(this.statusCode, this.message);
}
