import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/controller/jon_controller.dart'; 
import 'package:test/controller/saved_job_controller.dart';
import 'package:test/custom_widget/custom_jobcard.dart';
import 'package:test/features/home/job_details.dart';

class JobListScreen extends StatefulWidget {
  const JobListScreen({super.key});

  @override
  State<JobListScreen> createState() => _JobListScreenState();
}

class _JobListScreenState extends State<JobListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<JobController>(context, listen: false).fetchJobs());
  }

  @override
Widget build(BuildContext context) {
  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, Colors.blueAccent],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Consumer2<JobController, SavedJobsController>(
      builder: (context, jobCtrl, savedCtrl, _) {
        if (jobCtrl.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (jobCtrl.error != null) {
          return Center(child: Text('Error: ${jobCtrl.error}'));
        }

        final jobs = jobCtrl.jobs;
        if (jobs.isEmpty) {
          return const Center(child: Text('No jobs available'));
        }

        return RefreshIndicator(
          onRefresh: () => jobCtrl.fetchJobs(),
          child: ListView.builder(
            itemCount: jobs.length,
            itemBuilder: (context, i) {
              final job = jobs[i];
              return JobCard(
                job: job,
                onTap: () async {
                  final detail = await jobCtrl.fetchJobDetail(job.id);
                  if (detail != null && context.mounted) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => JobDetailScreen(job: detail),
                      ),
                    );
                  }
                },
                onApply: () {
                  savedCtrl.add(job);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Job saved to Saved Jobs')),
                  );
                },
              );
            },
          ),
        );
      },
    ),
  );
}
}