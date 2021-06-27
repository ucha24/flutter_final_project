import 'package:final_project/expense_data/cubit_data.dart';
import 'package:final_project/screens/home.dart';
import 'package:final_project/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController userId = TextEditingController();

  @override
  void dispose() {
    userId.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image:
                    const AssetImage('assets/images/logo.png'),
                height: MediaQuery.of(context).size.width / 2.5,
                width: MediaQuery.of(context).size.width / 2.5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 35,
                  child: TextFormField(
                    cursorColor: blackText,
                    cursorWidth: 1.0,
                    controller: userId,
                    decoration: InputDecoration(
                      errorStyle: const TextStyle(
                        height: 0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: greenPrimary,
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'fill UserID!';
                      }

                      return null;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          Home.routeName,
                          (route) => false,
                          arguments: userId.text,
                        );

                        BlocProvider.of<ExpenseDataCubit>(context)
                            .emit(ExpenseDataInitial());
                      }
                    },
                    child: const Text(
                      'LOGIN',
                      style: TextStyle(
                        color: blackText,
                        fontWeight: FontWeight.w700
                        ,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        greenPrimary,
                      ),
                      shadowColor: MaterialStateProperty.all<Color>(
                        Colors.transparent,
                      ),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
