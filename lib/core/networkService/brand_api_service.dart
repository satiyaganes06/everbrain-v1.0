import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../Model/brand_model.dart';
import '../../controller/search_brand_controller.getx.dart';
class BrandApiService {

 
  Future<List<Brand>> fetchBrandData(String searchValue) async {
  final response = await http.get(Uri.parse('https://api.brandfetch.io/v2/search/$searchValue'));
 // final response = await http.get(Uri.parse('https://autocomplete.clearbit.com/v1/companies/suggest?query=$searchValue'));

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    List<Brand> brands = [];

    for (var item in data) {
      brands.add(Brand.fromJson(item));
    }
    print(brands.toString());
    return brands;
  } else {
    Get.find<SearchBrandController>().errorMessage = 'Company not found';
    throw Exception('Failed to load data');
  }
}
}

// Future<List<Brand>> fetchBrandData(String searchValue) async {
//   //final response = await http.get(Uri.parse('https://api.brandfetch.io/v2/search/$searchValue'));
//   final response = await http.get(Uri.parse('https://autocomplete.clearbit.com/v1/companies/suggest?query=$searchValue'));

//   if (response.statusCode == 200) {
//     final List<dynamic> data = json.decode(response.body);
//     List<Brand> brands = [];

//     for (var item in data) {
//       brands.add(Brand.fromJson(item));
//     }
//     print(brands.toString());
//     return brands;

//   }else if (response.statusCode == 404)  {
//     Get.find<SearchBrandController>().errorMessage = 'Company not found';
//    // throw Exception('Company not found');
//    return [];

//   }else if (response.statusCode == 422)  {
//     Get.find<SearchBrandController>().errorMessage = 'Company name is invalid';
//    // throw Exception('Company name is invalid');
//    return [];

//   }else{
//     Get.find<SearchBrandController>().errorMessage = 'Failed to load data';
//    // throw Exception('Failed to load data');
//    print('jsj')
//    return [];
//   }
// }
