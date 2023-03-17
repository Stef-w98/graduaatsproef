import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:graduaatsproef/screens/bottom_navigation_bar.dart';
import 'package:graduaatsproef/screens/sign_up_screen.dart';
import 'package:graduaatsproef/services/supabase_state/auth_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  SignInScreenState createState() => SignInScreenState();
}

class SignInScreenState extends AuthState<SignInScreen> {
  var authRedirectUri = 'io.supabase.medremind://login-callback';
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 29, 29, 29),
        resizeToAvoidBottomInset: true,
        body: SizedBox(
          height: 768,
          width: 375,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 200.0,
                            child: Image.asset(
                              "assets/checkpoint.png",
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 16,
                              top: 6,
                              right: 16,
                            ),
                            child: Container(
                              //  width: 343,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(
                                  5,
                                ),
                              ),
                              child: TextFormField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  hintText: "Enter your email",
                                  hintStyle: const TextStyle(
                                      fontSize: 12.0, color: Colors.white),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      5,
                                    ),
                                    borderSide:
                                        const BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(
                                      5,
                                    ),
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 13, 245, 227)),
                                  ),
                                  prefixIcon: const Padding(
                                    padding: EdgeInsets.all(
                                      15,
                                    ),
                                    child: Icon(Icons.email_outlined,
                                        color: Colors.white),
                                  ),
                                  filled: true,
                                  fillColor: Colors.transparent,
                                ),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          Container(
                            width: 343,
                            height: 48,
                            margin: const EdgeInsets.only(
                              left: 16,
                              top: 8,
                              right: 16,
                            ),
                            child: TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: "Enter Password",
                                hintStyle: const TextStyle(
                                    fontSize: 12.0, color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    5,
                                  ),
                                  borderSide:
                                      const BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    5,
                                  ),
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(255, 13, 245, 227),
                                  ),
                                ),
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.all(
                                    15,
                                  ),
                                  child: Icon(Icons.lock_outline_rounded,
                                      color: Colors.white),
                                ),
                                filled: true,
                                fillColor: Colors.transparent,
                              ),
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              onTapBtnSignin();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 16,
                                top: 18,
                                right: 16,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 13, 245, 227),
                                  borderRadius: BorderRadius.circular(
                                    5,
                                  ),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                ),
                                alignment: Alignment.center,
                                height: 57,
                                width: 343,
                                child: const Text(
                                  "Sign In",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 375,
                            height: 21,
                            margin: const EdgeInsets.only(
                              top: 19,
                            ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 1,
                                    width: 134,
                                    margin: const EdgeInsets.only(
                                      left: 16,
                                      top: 10,
                                      bottom: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 21,
                                    width: 21,
                                    margin: const EdgeInsets.only(
                                      left: 28,
                                    ),
                                    child: const Text(
                                      "OR",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 1,
                                    width: 120,
                                    margin: const EdgeInsets.only(
                                      left: 23,
                                      top: 10,
                                      right: 16,
                                      bottom: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.blue.shade50,
                                        width: 1,
                                      ),
                                    ),
                                  )
                                ]),
                          ),
                          SignInButton(
                            Buttons.Google,
                            onPressed: () {
                              onTapBtnGoogleSignin();
                            },
                          ),
                          SignInButton(
                            Buttons.FacebookNew,
                            onPressed: () {
                              onTapBtnFacebookSignin();
                            },
                          ),
                          SignInButton(
                            Buttons.GitHub,
                            onPressed: () {
                              onTapBtnGithubSignin();
                            },
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUpScreen()),
                              );
                            },
                            child: Container(
                              width: 212,
                              margin: const EdgeInsets.only(
                                left: 81,
                                top: 8,
                                right: 82,
                              ),
                              child: RichText(
                                  text: TextSpan(children: <InlineSpan>[
                                    TextSpan(
                                      text: "Don't have an account?",
                                      style: TextStyle(
                                          color: Colors.blueGrey.shade300,
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400),
                                    ),
                                    TextSpan(
                                      text: ' ',
                                      style: TextStyle(
                                          color: Colors.indigo.shade300,
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const TextSpan(
                                      text: "SignUp",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 13, 245, 227),
                                          fontSize: 12,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w700),
                                    )
                                  ]),
                                  textAlign: TextAlign.center),
                            ),
                          )
                        ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTapBtnSignin() async {
    final response = await Supabase.instance.client.auth.signIn(
      email: emailController.text,
      password: passwordController.text,
    );
    if (response.error != null) {
      final snackbar = SnackBar(content: Text(response.error!.message));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => BottomNavigation(NavigationPage.homeScreen)),
      );
    }
  }

  void onTapBtnGoogleSignin() async {
    await Supabase.instance.client.auth.signInWithProvider(
      Provider.google,
      options: AuthOptions(redirectTo: authRedirectUri),
    );
  }

  void onTapBtnFacebookSignin() async {
    await Supabase.instance.client.auth.signInWithProvider(
      Provider.facebook,
      options: AuthOptions(redirectTo: authRedirectUri),
    );
  }

  void onTapBtnGithubSignin() async {
    await Supabase.instance.client.auth.signInWithProvider(
      Provider.github,
      options: AuthOptions(redirectTo: authRedirectUri),
    );
  }
}
