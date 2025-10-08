import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/controller/saved_job_controller.dart';
import 'package:test/custom_widget/custom_jobcard.dart';
import 'package:test/features/home/job_details.dart';


class SavedJobsScreen extends StatelessWidget {
  const SavedJobsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<SavedJobsController>(
      builder: (context, saved, _) {
        if (saved.saved.isEmpty) {
          return Center(child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('No saved jobs yet.'),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => saved.loadSavedJobs(),
                child: const Text('Reload'),
              )
            ],
          ));
        }
        return ListView.builder(
          itemCount: saved.saved.length,
          itemBuilder: (context, i) {
            final job = saved.saved[i];
            return JobCard(
              job: job,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => JobDetailScreen(job: job)));
              },
              onApply: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Already saved')));
              },
            );
          },
        );
      },
    );
  }
}
