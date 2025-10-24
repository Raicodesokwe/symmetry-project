import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:symmetryproject/config/theme/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'features/articles/presentation/bloc/articles_bloc.dart';
import 'features/articles/presentation/bloc/articles_event.dart';
import 'injection.dart' as di;
import 'features/articles/presentation/pages/articles_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //lock screen orientation
   await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp();
  di.configureDependencies(); // setup DI
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Symmetry Project',
      theme: themeData(context),
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
         create: (_) => ArticlesBloc(
          getArticles: di.getIt(),
        )..add(FetchArticles()),
        child: const ArticlesPage()),
    );
  }
}

