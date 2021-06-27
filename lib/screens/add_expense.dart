import 'dart:ui';

import 'package:final_project/models/expense.dart';
import 'package:final_project/expense_data/cubit_data.dart';
import 'package:final_project/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({Key? key}) : super(key: key);

  @override
  _AddExpenseState createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController amount = TextEditingController();
  final TextEditingController title = TextEditingController();
  final TextEditingController date = TextEditingController(
    text: 'Choose Date',
  );

  @override
  void dispose() {
    amount.dispose();
    title.dispose();
    date.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 2,
        sigmaY: 2,
      ),
      child: Container(
        color: lightBackground,
        child: Padding(
          padding: const EdgeInsets.all(35.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Card(
                  color: Colors.transparent,
                  shadowColor: Colors.transparent,
                  child: SizedBox(
                    child: TextFormField(
                      cursorColor: blackText,
                      cursorWidth: 1.0,
                      textAlign: TextAlign.center,
                      controller: amount,
                      decoration: const InputDecoration(
                        hintText: 'Please fill amount',
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: blackText,
                          ),
                        ),
                      ),
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            double.tryParse(value) == null ||
                            double.parse(value) < 0) {
                          return 'Please fill amount!';
                        }

                        return null;
                      },
                    ),
                  ),
                ),
                Card(
                  color: Colors.transparent,
                  shadowColor: Colors.transparent,
                  child: SizedBox(
                    child: TextFormField(
                      cursorColor: blackText,
                      cursorWidth: 1.0,
                      textAlign: TextAlign.center,
                      controller: title,
                      decoration: const InputDecoration(
                        hintText: 'Please fill title',
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: blackText,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please fill title!';
                        }

                        return null;
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 16.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(date.text),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        child: ElevatedButton(
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(0),
                              lastDate: DateTime.now(),
                            ).then((value) {
                              if (value != null) {
                                date.text = value
                                    .toString()
                                    .substring(0, 10)
                                    .split('-')
                                    .reversed
                                    .join('/');

                                setState(() {});
                              }
                            });
                          },
                          child: const Text('Choose Date'),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              green,
                            ),
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shadowColor: MaterialStateProperty.all<Color>(
                            Colors.transparent,
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            green,
                          ),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<ExpenseDataCubit>(context).create(
                              Expense(
                                title: title.text,
                                amount: double.parse(amount.text),
                                date: date.text != 'Choose Date'
                                    ? date.text
                                    : DateTime.now()
                                        .toString()
                                        .substring(0, 10)
                                        .split('-')
                                        .reversed
                                        .join('/'),
                              ),
                            );

                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Add'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
