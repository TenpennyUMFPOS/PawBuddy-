import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project_integration_pb/core/common/loader.dart';
import 'package:project_integration_pb/core/common/sign_in_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_integration_pb/features/auth/controller/auth_controller.dart';



class LoginScreen extends ConsumerWidget{
  const LoginScreen({super.key});



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authControllerProvider);
    return Scaffold(


        body: isLoading
            ? const Loader()
            :  Column(
          children: [
            const SizedBox(height: 150),
            const Text(
              '   Paw Buddy \nWelcomes you ',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            Container(
              child: Lottie.network(
                "https://assets7.lottiefiles.com/packages/lf20_2ixzdfvy.json"
                ,width:550,
              ),
            ),
            const SizedBox(height: 20),
            const SignInButton(),



          ],
        )
    );
  }
}