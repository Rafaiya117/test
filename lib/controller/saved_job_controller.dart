import 'package:flutter/material.dart';
import 'package:test/model/job_model.dart';
import 'package:test/services/local_storage.dart';


class SavedJobsController extends ChangeNotifier {
  final LocalStorageService _local = LocalStorageService();
  List<JobModel> saved = [];

  Future<void> loadSavedJobs() async {
    saved = await _local.loadSavedJobs();
    notifyListeners();
  }

  Future<void> add(JobModel job) async {
    if (saved.any((j) => j.id == job.id)) return;
    saved.add(job);
    await _local.saveJobs(saved);
    notifyListeners();
  }

  Future<void> remove(JobModel job) async {
    saved.removeWhere((j) => j.id == job.id);
    await _local.saveJobs(saved);
    notifyListeners();
  }

  bool isSaved(int id) => saved.any((j) => j.id == id);

  int count() => saved.length;
}
