import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/person.dart';

class ApiService {
  
  static const String _apiKey = '136dd351243aa1964767481fb95cd702';
  static const String _baseUrl = 'https://api.themoviedb.org/3';

  /// Fetches the list of popular people (Step 1 from the assignment)
  Future<PopularPeopleResponse> getPopularPeople({int page = 1}) async {
    final url = Uri.parse(
      '$_baseUrl/person/popular?api_key=$_apiKey&page=$page',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      return PopularPeopleResponse.fromJson(data);
    } else {
      throw Exception(
        'Failed to load popular people (status ${response.statusCode})',
      );
    }
  }

  /// Fetches detailed info for a single person (Step 3 from the assignment)
  Future<PersonDetail> getPersonDetail(int personId) async {
    final url = Uri.parse('$_baseUrl/person/$personId?api_key=$_apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      return PersonDetail.fromJson(data);
    } else {
      throw Exception(
        'Failed to load person detail (status ${response.statusCode})',
      );
    }
  }
}