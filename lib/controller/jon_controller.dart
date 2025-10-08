import 'package:flutter/material.dart';
import 'package:test/model/job_model.dart';
import 'package:test/services/api_service.dart';


class JobController extends ChangeNotifier {
  final ApiService _api = ApiService();

  bool loading = false;
  List<JobModel> jobs = [];
  String? error;

  Future<void> fetchJobs() async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      jobs = await _api.fetchJobs();
    } catch (e) {
      error = e.toString();
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<JobModel?> fetchJobDetail(int id) async {
    try {
      return await _api.fetchJobDetail(id);
    } catch (e) {
      error = e.toString();
      notifyListeners();
      return null;
    }
  }
}
