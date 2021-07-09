import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuto_domain_driven_design/application/auth/auth_bloc.dart';
import 'package:tuto_domain_driven_design/presentation/routes/router.gr.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /* return const Scaffold(
        body: Center(
      child: Text("SplashScreen"),
    )); */
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        print("Are you there ?");
        state.map(
          initial: (_) {
            print('initial');
            //context.pushRoute(const SignInPageRoute());
          },
          authenticated: (_) {
            print('I am authenticated');
            //context.pushRoute(const SignInPageRoute());
          },
          unauthenticated: (_) {
            print("Unauthenticated");
            //context.pushRoute(const SignInPageRoute());
            Navigator.pushNamed(context, '/sign-in');
          },
        );
      },
      child: const Scaffold(
          body: Center(
        child: Text("SplashScreen"),
      )),
    );
  }
}
