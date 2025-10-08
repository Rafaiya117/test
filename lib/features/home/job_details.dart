import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/controller/saved_job_controller.dart';
import 'package:test/model/job_model.dart';


class JobDetailScreen extends StatelessWidget {
  final JobModel job;
  const JobDetailScreen({super.key, required this.job});

  @override
  Widget build(BuildContext context) {
    final savedCtrl = Provider.of<SavedJobsController>(context);
    final isSaved = savedCtrl.isSaved(job.id);
    return Scaffold(
      appBar: AppBar(title: const Text('Job Detail')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(job.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('${job.company} • ${job.location}'),
            const SizedBox(height: 12),
            Text('Salary: ৳ ${job.salary.toStringAsFixed(0)}'),
            const SizedBox(height: 12),
            Expanded(child: SingleChildScrollView(child: Text(job.description))),
            Row(
              children: [
                ElevatedButton.icon(
                  icon: Icon(isSaved ? Icons.check : Icons.bookmark_add),
                  label: Text(isSaved ? 'Saved' : 'Save Job'),
                  onPressed: isSaved
                      ? null
                      : () {
                          savedCtrl.add(job);
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Saved')));
                        },
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  icon: const Icon(Icons.send),
                  label: const Text('Apply'),
                  onPressed: () {
                    savedCtrl.add(job);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Applied (mock)')));
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
