import 'dart:async';
import 'package:lookme/utils/constants/colors.dart';
import 'package:lookme/utils/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:lookme/utils/constants/sizes.dart';
import 'package:lookme/controllers/auth_controller.dart';

class Splash extends StatefulWidget {
  const Splash({ super.key });

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  
  Future<void> checkAuthStatus() async {
    final isLoggedIn = await AuthController.isLoggedIn();
    
    if (mounted) {
      Timer(const Duration(seconds: 2), () {
        if (isLoggedIn) {
          Navigator.pushReplacementNamed(context, '/main_home');
        } else {
          Navigator.pushReplacementNamed(context, '/signin');
        }
      });
    }
  }

  @override
  void initState(){
    super.initState();
    checkAuthStatus();
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: IKColors.card,
      body: Center(
        child: Container(
           constraints: const BoxConstraints(
            maxWidth: IKSizes.container,
          ),
          width: double.maxFinite,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(IKImages.splash),
              fit: BoxFit.contain,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text('VERSION 1.0',style: Theme.of(context).textTheme.titleSmall?.merge(const TextStyle(color: IKColors.secondary))),
              ),
            ],
          ),
        )
      ),
    );
  }
}