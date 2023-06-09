import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Models/ProductModel.dart';

const baseURL = "http://10.0.2.2:3000";

class APIService {
  static var client = http.Client();

  static addProduct(ProductModel product) async {
  Map<String, String> requestHeaders = {'Content-Type' : 'application/json'};
    var response = await http.post(Uri.parse("$baseURL/addProduct"),
    headers: requestHeaders,
    body:
     json.encode(product.toJson())
    );
  }

  static getNoti() async {
  Map<String, String> requestHeaders = {'Content-Type' : 'application/json'};
  var response = await http.get(Uri.parse("$baseURL/notifications"),
  headers: requestHeaders
  );
  return json.decode(response.body);
  }

  static eachnotis(String email) async{
    Map<String, String> requestHeaders = {'Content-Type' : 'application/json'};
    var response = await http.post(Uri.parse("$baseURL/eachNoti"),
    headers: requestHeaders,
    body: 
      jsonEncode({
        "email": email
  }));
  return json.decode(response.body);
  }

  static confirmnoti(String email) async {
     Map<String, String> requestHeaders = {'Content-Type' : 'application/json'};
     var response = await http.post(Uri.parse("$baseURL/confirmnoti"),
     headers: requestHeaders,
     body: jsonEncode({
      "email": email
     }));
  }

  static search(String prefix) async {
    Map<String, String> requestHeaders = {'Content-Type' : 'application/json'};
    var response = await http.post(Uri.parse("$baseURL/products"),
    headers: requestHeaders,
    body: jsonEncode({
      "prefix": prefix
    }));
    if(response.body.isNotEmpty) {
    return json.decode(response.body);
  }
  return {};
  } 

    static removeprod(String name) async {
     Map<String, String> requestHeaders = {'Content-Type' : 'application/json'};
     var response = await http.post(Uri.parse("$baseURL/removeprod"),
     headers: requestHeaders,
     body: jsonEncode({
      "name": name
     }));
  }
}