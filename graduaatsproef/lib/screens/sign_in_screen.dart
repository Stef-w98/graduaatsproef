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
  var authRedirectUri = 'io.supabase.checkpoint://login-callback';
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _passwordInvisable = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 29, 29, 29),
        resizeToAvoidBottomInset: true,
        body: Align(
          alignment: const AlignmentDirectional(-0.14, -0.08),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0x19444D59),
              image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: AssetImage(
                  'assets/images/launchScreen.png',
                ),
              ),
            ),
            child: SizedBox(
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
                              const SizedBox(
                                height: 30.0,
                              ),
                              SizedBox(
                                height: 220.0,
                                child: Image.asset(
                                  "assets/images/checkpoint.png",
                                ),
                              ),
                              const SizedBox(height: 60.0),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    40, 0, 40, 20),
                                child: Container(
                                  width: double.infinity,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1A1F24),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            12, 0, 20, 0),
                                    child: TextFormField(
                                      controller: emailController,
                                      obscureText: false,
                                      decoration: const InputDecoration(
                                        labelText: 'Email',
                                        hintText: 'Email Address',
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(4.0),
                                            topRight: Radius.circular(4.0),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(4.0),
                                            topRight: Radius.circular(4.0),
                                          ),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(4.0),
                                            topRight: Radius.circular(4.0),
                                          ),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(4.0),
                                            topRight: Radius.circular(4.0),
                                          ),
                                        ),
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    40, 0, 40, 20),
                                child: Container(
                                  width: double.infinity,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1A1F24),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            12, 0, 20, 0),
                                    child: TextFormField(
                                      controller: passwordController,
                                      obscureText: _passwordInvisable,
                                      decoration: InputDecoration(
                                        labelText: 'Password',
                                        hintText: 'Enter Password',
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(4.0),
                                            topRight: Radius.circular(4.0),
                                          ),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(4.0),
                                            topRight: Radius.circular(4.0),
                                          ),
                                        ),
                                        errorBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(4.0),
                                            topRight: Radius.circular(4.0),
                                          ),
                                        ),
                                        focusedErrorBorder:
                                            const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Color(0x00000000),
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(4.0),
                                            topRight: Radius.circular(4.0),
                                          ),
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _passwordInvisable
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: Colors.grey[400],
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _passwordInvisable =
                                                  !_passwordInvisable;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  onTapBtnSignin();
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          const Color(0xFF4B39EF)),
                                  elevation:
                                      MaterialStateProperty.all<double>(4),
                                  padding: MaterialStateProperty.all<
                                          EdgeInsetsGeometry>(
                                      const EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 120)),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30))),
                                ),
                                child: const Text(
                                  'Log In',
                                  style: TextStyle(
                                    fontFamily: 'Lexend Deca',
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUpScreen()),
                                  );
                                },
                                child: Container(
                                  width: 252,
                                  margin: const EdgeInsets.only(
                                    left: 0,
                                    top: 16,
                                    right: 0,
                                  ),
                                  child: RichText(
                                      text: TextSpan(children: <InlineSpan>[
                                        TextSpan(
                                          text: "Don't have an account?",
                                          style: TextStyle(
                                              color: Colors.blueGrey.shade300,
                                              fontSize: 16,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w400),
                                        ),
                                        TextSpan(
                                          text: '     ',
                                          style: TextStyle(
                                              color: Colors.indigo.shade300,
                                              fontSize: 18,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w700),
                                        ),
                                        const TextSpan(
                                          text: "SignUp",
                                          style: TextStyle(
                                              color: Color(0xFF4B39EF),
                                              fontSize: 18,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w700),
                                        )
                                      ]),
                                      textAlign: TextAlign.center),
                                ),
                              ),
                              const Align(
                                alignment: AlignmentDirectional(0, 1),
                                child: Padding(
                                  padding: EdgeInsets.only(top: 250.0),
                                  child: Text(
                                    'Version 0.1.2',
                                    style: TextStyle(
                                      color: Colors
                                          .grey, // set the text color to black with 87% opacity
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
            builder: (context) =>
                const BottomNavigation(NavigationPage.checkInOutScreen)),
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
