import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:flutter_node/model/product_model.dart';
import 'package:http/http.dart' as http;

class Api {
  static const baseUrl = "http://192.168.137.1/api/";
//add method
  static addproduct(Map pdata) async {
    print(pdata);
    var url = Uri.parse("${baseUrl}add_product");
    try {
      final res = await http.post(url, body: pdata);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        print(data);
      } else {
        print("Faild to get response");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

//get method
  static getProduct() async {
    List<Product> products = [];
    var url = Uri.parse("${baseUrl}get_product");
    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);

        data['products'].forEach((value) => {
              products.add(Product(
                name: value['pname'],
                desc: value['pdesc'],
                price: value['pprice'],
                id: value['id'].toString(),
              )),
            });
        return products;
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
    }
  }

//update method
  static updateProduct(id, body) async {
    var url = Uri.parse(baseUrl + "update/$id");
    final res = await http.post(url, body: body);
    if (res.statusCode == 200) {
      print(jsonDecode(res.body));
    } else {
      print("Failed to update data");
    }
  }

  // delete method
  static deleteProduct(id) async {
    var url = Uri.parse("${baseUrl}delete/$id");
    final res = await http.post(url);
    if (res.statusCode == 204) {
      print(jsonDecode(res.body));
    } else {
      print("failed to delete");
    }
  }
}
