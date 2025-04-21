import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lookme/components/social/social_button.dart';
import 'package:lookme/utils/constants/images.dart';
import 'package:lookme/controllers/auth_controller.dart';
import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';

class SignIn extends StatefulWidget {
  const SignIn({ super.key });

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _handleLogin() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    setState(() => _isLoading = true);

    final result = await AuthController.login(
      _emailController.text,
      _passwordController.text,
    );

    setState(() => _isLoading = false);

    if (result['success'] == true) {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/main_home');
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result['message'])),
        );
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child :Center(
          child:Container(
            alignment: Alignment.topCenter,
            constraints:const BoxConstraints(
              maxWidth: IKSizes.container,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(150)),
                        child: Image.asset(
                            IKImages.authbanner1,
                            width: double.infinity, 
                            height: 170, 
                            fit:BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 30, right: 30,top: 25,bottom: 10),
                    constraints: const BoxConstraints(
                      maxWidth: IKSizes.container
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('Sign In To Your Account', 
                          style: Theme.of(context).textTheme.headlineLarge,
                          textAlign: TextAlign.left,
                          maxLines: 1,
                        ),
                        const SizedBox(height: 8),
                        Text("Welcome Back You've Been Missed!",
                          style : Theme.of(context).textTheme.bodyLarge?.merge( TextStyle(color: Theme.of(context).textTheme.titleMedium?.color,fontSize: 15)),
                          textAlign: TextAlign.left,
                          maxLines: 3,
                        ),
                        const SizedBox(height: 15),
                        Text('Email Address',
                          style: Theme.of(context).textTheme.labelMedium?.merge(TextStyle(color: Theme.of(context).textTheme.titleMedium?.color,fontSize: 15, fontWeight: FontWeight.w500)),                    
                        ),
                        const SizedBox(height: 5),
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(15),
                            filled: true,
                            border: OutlineInputBorder(),
                            fillColor:Theme.of(context).canvasColor,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).canvasColor,width: 2.0),
                              borderRadius: BorderRadius.circular(0)
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color:Theme.of(context).brightness == Brightness.dark ? IKColors.card: IKColors.secondary,width: 2.0),
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                          style: Theme.of(context).textTheme.headlineMedium?.merge(const TextStyle(fontWeight: FontWeight.w400)),
                        ),
                        const SizedBox(height: 15),
                        Text('Password',
                          style: Theme.of(context).textTheme.labelMedium?.merge(TextStyle(color: Theme.of(context).textTheme.titleMedium?.color,fontSize: 15, fontWeight: FontWeight.w500)),                    
                        ),
                        const SizedBox(height: 5),
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(15),
                            filled: true,
                            border: OutlineInputBorder(),
                            fillColor:Theme.of(context).canvasColor,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).canvasColor,width: 2.0),
                              borderRadius: BorderRadius.circular(0)
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color:Theme.of(context).brightness == Brightness.dark ? IKColors.card: IKColors.secondary,width: 2.0),
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                          style: Theme.of(context).textTheme.headlineMedium?.merge(const TextStyle(fontWeight: FontWeight.w400)),
                        ),
                        const SizedBox(height: 5),
                        RichText(
                          textAlign: TextAlign.right,
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Forgot Password?',
                              style:
                                Theme.of(context).textTheme.labelMedium?.merge(
                                  TextStyle(color: Theme.of(context).textTheme.titleMedium?.color,fontSize: 15, fontWeight: FontWeight.w500, decoration: TextDecoration.underline,decorationColor:Theme.of(context).textTheme.titleMedium?.color,decorationThickness: 2.0, )
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    Navigator.pushNamed(context, '/forget');
                                }
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _handleLogin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).textTheme.titleMedium?.color,
                              side: const BorderSide(color: IKColors.secondary),
                              foregroundColor: Theme.of(context).cardColor
                            ), 
                            child: _isLoading 
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                )
                              : const Text('Sign in')),
                        ),
                        const SizedBox(height: 40),
                       
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: "Not a member?",
                            style: Theme.of(context).textTheme.titleMedium?.merge(const TextStyle(fontWeight: FontWeight.w400)),
                            children: <TextSpan>[
                              TextSpan(
                                text: ' Create an account',
                                style: const TextStyle(color: IKColors.primary,fontWeight: FontWeight.w600,decoration: TextDecoration.underline,decorationColor:IKColors.primary,decorationThickness: 2.0,),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    Navigator.pushNamed(context, '/signup');
                                }
                              ),
                            ],
                          ),
                      ),
                      ],
                    ),
                  )
                ]
              ),
            )
          ),
        )
      ),
    );
  }
}