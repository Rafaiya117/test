import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/model/job_model.dart';


class LocalStorageService {
  static const _keyEmail = 'user_email';
  static const _keyPassword = 'user_password';
  static const _keySavedJobs = 'saved_jobs';

  Future<void> saveCredentials(String email, String password) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString(_keyEmail, email);
    await sp.setString(_keyPassword, password);
  }

  Future<Map<String, String>?> getCredentials() async {
    final sp = await SharedPreferences.getInstance();
    final email = sp.getString(_keyEmail);
    final password = sp.getString(_keyPassword);
    if (email != null && password != null) {
      return {'email': email, 'password': password};
    }
    return null;
  }

  Future<void> saveJobs(List<JobModel> jobs) async {
    final sp = await SharedPreferences.getInstance();
    final jsonList = jobs.map((j) => json.encode(j.toJson())).toList();
    await sp.setStringList(_keySavedJobs, jsonList);
  }

  Future<List<JobModel>> loadSavedJobs() async {
    final sp = await SharedPreferences.getInstance();
    final list = sp.getStringList(_keySavedJobs) ?? [];
    return list.map((s) {
      final m = json.decode(s) as Map<String, dynamic>;
      return JobModel.fromLocalJson(m);
    }).toList();
  }

  Future<void> clearAll() async {
    final sp = await SharedPreferences.getInstance();
    await sp.clear();
  }
}
