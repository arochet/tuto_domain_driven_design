import 'package:flutter/material.dart';
import 'package:tuto_domain_driven_design/application/auth/auth_bloc.dart';

class ToDelete extends StatelessWidget {
  const ToDelete({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: const Text("SignOut"),
        ),
      ),
    );
  }
}
