import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test/model/job_model.dart';


class JobCard extends StatelessWidget {
  final JobModel job;
  final VoidCallback onTap;
  final VoidCallback onApply;

  const JobCard({
    super.key, 
    required this.job, 
    required this.onTap, 
    required this.onApply
    });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: ListTile(
        onTap: onTap,
        leading: job.thumbnail.isNotEmpty
            ? Image.network(job.thumbnail, width: 56, height: 56, fit: BoxFit.cover, errorBuilder: (_, __, ___) => const Icon(Icons.work))
            : const Icon(Icons.work_outline),
        title: Text(job.title),
        subtitle: Text('${job.company} • ${job.location}'),
        trailing: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('৳ ${job.salary.toStringAsFixed(0)}'),
            //const SizedBox(height: 6),
            SizedBox(
              height: 32.h,
              child: ElevatedButton(onPressed: onApply, child: const Text('Apply'))),
          ],
        ),
      ),
    );
  }
}
