import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:test/app_router/routers.dart';
import 'package:test/controller/auth_controller.dart';
import 'package:test/controller/jon_controller.dart';
import 'package:test/controller/saved_job_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
        ChangeNotifierProvider(create: (_) => JobController()),
        ChangeNotifierProvider(create: (_) => SavedJobsController()),
      ],
      builder: (context, _) {
        final auth = Provider.of<AuthController>(context);
        final router = buildRouter(auth); 

        return ScreenUtilInit(
          designSize: const Size(375, 850),
          minTextAdapt: true,
          builder: (_, __) => MaterialApp.router(
            title: 'Mini Job Portal',
            theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
            routerConfig: router,
            debugShowCheckedModeBanner: false,
          ),
        );
      },
    );
  }
}
