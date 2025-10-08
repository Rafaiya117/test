import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test/model/job_model.dart';

class ApiService {
  static const String base = 'https://dummyjson.com';

  Future<List<JobModel>> fetchJobs() async {
    final uri = Uri.parse('$base/products');
    final res = await http.get(uri);
    if (res.statusCode == 200) {
      final body = json.decode(res.body) as Map<String, dynamic>;
      final List<dynamic> list = body['products'] ?? [];
      return list.map((e) => JobModel.fromJson(e as Map<String, dynamic>)).toList();
    } else {
      throw Exception('Failed to load jobs: ${res.statusCode}');
    }
  }

  Future<JobModel> fetchJobDetail(int id) async {
    final uri = Uri.parse('$base/products/$id');
    final res = await http.get(uri);
    if (res.statusCode == 200) {
      final body = json.decode(res.body) as Map<String, dynamic>;
      return JobModel.fromJson(body);
    } else {
      throw Exception('Failed to load job detail');
    }
  }
}
