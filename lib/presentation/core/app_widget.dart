import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuto_domain_driven_design/application/auth/auth_bloc.dart';
import 'package:tuto_domain_driven_design/injection.dart';

import 'package:tuto_domain_driven_design/presentation/sign_in/sign_in.dart';
import 'package:tuto_domain_driven_design/presentation/splash/splash_page.dart';
import 'package:tuto_domain_driven_design/presentation/to_delete/to-delete.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt<AuthBloc>()..add(const AuthEvent.authCheckRequested()),
        )
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
        initialRoute: '/',
        routes: {
          '/': (context) => SplashPage(),
          '/sign-in': (context) => SignInPage(),
          '/to-delete': (context) => ToDelete(),
        },

        /* builder: (context, widget) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Test"),
              ),
              body: ElevatedButton(
                onPressed: () {
                  context
                      .read<AuthBloc>()
                      .add(const AuthEvent.authCheckRequested());
                },
                child: const Text('Fuck'),
              ),
            );
          } */
      ),
    );
  }
}
