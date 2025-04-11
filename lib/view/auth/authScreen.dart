//import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import '../../controller/authController.dart';

class AuthScreen extends StatefulWidget {
  static const String routeName = "/auth-screen";
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var signUpKey = GlobalKey<FormState>();
  var signInKey = GlobalKey<FormState>();

  void SignedUpSubmit(String email, String name, String password) {
    final isValid = signUpKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    signUpKey.currentState!.save();
    AuthController().signUpUser(
        context: context, email: email, name: name, password: password);
  }

  void signIn() {
      AuthController().signInUser(
        context: context,
        email: emailController.text,
        password: passwordController.text);
  }

  void SignedInSubmit() {
    final isValid = signInKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    signInKey.currentState!.save();
    signIn();
  }

  bool isLoggedIn = false;

  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Amazon Clone"),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
          child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
            height: MediaQuery.sizeOf(context).height - 150,
            child: isLoggedIn
                ? Form(
                    key: signInKey,
                    child: Column(
                      children: [
                        const Text(
                          "Sign in with your email and password",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Sign In',
                              style: TextStyle(
                                  fontSize: 27, fontWeight: FontWeight.bold),
                            ),
                            TextButton(
                                onPressed: () {},
                                child: const Text(
                                  'Forgot Password',
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty ||
                                !RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                                    .hasMatch(value)) {
                              return 'Enter a valid email';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              hintText: "Email",
                              hintStyle: TextStyle(fontWeight: FontWeight.w300),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black))),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            RegExp regex = RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                            if (value!.isEmpty) {
                              return 'Please enter password';
                            } else {
                              if (value.length<6) {
                                return 'Enter valid password';
                              } else {
                                return null;
                              }
                            }
                          },
                          obscureText: true,
                          decoration: const InputDecoration(
                              hintText: "Password",
                              hintStyle: TextStyle(fontWeight: FontWeight.w300),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black))),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CheckboxListTile(
                          value: true,
                          onChanged: (value) {},
                          title: const Text('Show Password'),
                        ),
                        CheckboxListTile(
                          value: true,
                          onChanged: (value) {},
                          title: const Text('Keep me signed in Detail'),
                        ),
                        InkWell(
                            onTap: () => SignedInSubmit(),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width / 2 -
                                          40,
                                  vertical: 20),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                  color: Colors.orangeAccent),
                              child: const Text('Sign In'),
                            )),
                        // ElevatedButton(onPressed: (){}, child: Text("Sign In",style: TextStyle(color: Colors.white),),
                        // style: ElevatedButton.styleFrom(
                        //   backgroundColor: Colors.amber,
                        //   shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(2)
                        //   )
                        // ),),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(
                          color: Colors.white,
                          thickness: 1,
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        const Text('New To Amazon Clone'),
                        const SizedBox(
                          height: 15,
                        ),
                        InkWell(
                            onTap: () {
                              setState(() {
                                isLoggedIn = false;
                              });
                              print('CLICK');
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width / 2 -
                                          100,
                                  vertical: 20),
                              decoration:
                                  BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.orange[200]),
                              child: const Text('Create a new Account'),
                            )),
                        const Spacer(),
                        TextButton(
                            onPressed: () {},
                            child:
                                const Text("Conditions of Use Privacy Notice"))
                      ],
                    ),
                  )
                :

                //Signed up Screen

                SingleChildScrollView(
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SizedBox(
                            height: MediaQuery.sizeOf(context).height - 50,
                            child: Form(
                              key: signUpKey,
                              child: Column(
                                children: [
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Create Account',
                                        style: TextStyle(
                                            fontSize: 27,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    controller: nameController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Please enter your name";
                                      } else {
                                        return null;
                                      }
                                    },
                                    decoration: const InputDecoration(
                                        hintText: "Your Name",
                                        hintStyle: TextStyle(
                                            fontWeight: FontWeight.w300),
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.red)),
                                        errorBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.red)),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black))),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    validator: (value) {
                                      if (value!.isEmpty ||
                                          !RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                                              .hasMatch(value)) {
                                        return 'Enter a valid email';
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                        hintText: "Email",
                                        hintStyle: TextStyle(
                                            fontWeight: FontWeight.w300),
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.red)),
                                        errorBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.red)),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black))),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    controller: passwordController,
                                    keyboardType: TextInputType.visiblePassword,
                                    validator: (value) {
                                      RegExp regex = RegExp(
                                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                                      if (value!.isEmpty) {
                                        return 'Please enter password';
                                      } else {
                                        if (!regex.hasMatch(value)) {
                                          return 'Enter valid password';
                                        } else {
                                          return null;
                                        }
                                      }
                                    },
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                        hintText: "Password",
                                        hintStyle: TextStyle(
                                            fontWeight: FontWeight.w300),
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.red)),
                                        errorBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.red)),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black))),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Password must be atleast 6 charater',
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.visiblePassword,
                                    validator: (value) {
                                      RegExp regex = RegExp(
                                          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                                      if (value!.isEmpty) {
                                        return 'Please enter password';
                                      } else {
                                        if (!regex.hasMatch(value)) {
                                          return 'Enter valid password';
                                        } else {
                                          return null;
                                        }
                                      }
                                    },
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                        hintText: "Re enter Password",
                                        hintStyle: TextStyle(
                                            fontWeight: FontWeight.w300),
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.red)),
                                        errorBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.red)),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black))),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  InkWell(
                                      onTap: () => SignedUpSubmit(
                                          emailController.text,
                                          nameController.text,
                                          passwordController.text),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2 -
                                                100,
                                            vertical: 20),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                            color: Colors.orangeAccent),
                                        child:
                                            const Text('Create your Account'),
                                      )),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Divider(
                                    color: Colors.white,
                                    thickness: 1,
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  const Text('Already a customer?'),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          isLoggedIn = true;
                                        });
                                  
                                        print('CLICK');
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2 -
                                                50,
                                            vertical: 20),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                                            color: Colors.orange[200]),
                                        child: const Text('Sign In'),
                                      )),
                                  const Spacer(),
                                  TextButton(
                                      onPressed: () {},
                                      child: const Text(
                                          "By creating a account you agree Amazon Clone's Conditions of Use and Privacy Notice.", textAlign: TextAlign.center,))
                                ],
                              ),
                            )),
                      ),
                    ),
                  ),
          ),
        ),
      )),
    );
  }
}
