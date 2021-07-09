import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuto_domain_driven_design/application/auth/auth_bloc.dart';
import 'package:tuto_domain_driven_design/injection.dart';

import 'package:tuto_domain_driven_design/presentation/sign_in/sign_in.dart';
import 'package:tuto_domain_driven_design/presentation/splash/splash_page.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                getIt<AuthBloc>()..add(const AuthEvent.authCheckRequested()))
      ],
      child: MaterialApp(
        title: 'Note',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          primaryColor: Colors.green[800],
          accentColor: Colors.blueAccent,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.blue[900],
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        /* initialRoute: '/',
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/': (context) => SplashPage(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/sign-in': (context) => SignInPage(),
        }, */
        home: SplashPage(),
      ),
    );
  }
}