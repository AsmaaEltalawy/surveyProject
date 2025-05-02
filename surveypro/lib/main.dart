import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surveypro/modules/all_data_screen.dart';
import 'package:surveypro/modules/home_screen.dart';
import 'package:surveypro/modules/login_screen.dart';
import 'package:surveypro/modules/splash_screen.dart';
import 'package:surveypro/services/survey_survices.dart';
import 'package:surveypro/theme/application_theme.dart';
import 'bloc/dashboard_bloc.dart';
import 'bloc/dashboard_event.dart';
import 'bloc/login_bloc.dart';
import 'bloc/visualization_bloc.dart';
import 'bloc/visualization_event.dart';
import 'modules/visualization.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final SurveyService surveyService = SurveyService();
   MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => VisualizationBloc(surveyService)..add(FetchVisualizationData())),
          BlocProvider(create: (context) => LoginBloc()),
          BlocProvider(create: (context) => DashboardBloc()..add(LoadDashboardData())),
        ],
    child:MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routesName,
      theme: ApplicationTheme.lightMode,
      routes: {
        HomeScreen.routeName:(context)=>HomeScreen(),
        Visualization.routeName:(context)=>Visualization(),
        SplashScreen.routesName:(context)=>const SplashScreen(),
        LoginScreen.routesName:(context)=>LoginScreen(),
        AllDataScreen.routesName:(context)=> const AllDataScreen(),
      },
    )
    );
  }
}

