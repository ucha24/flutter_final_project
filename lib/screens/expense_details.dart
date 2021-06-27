import 'dart:ui';

import 'package:final_project/models/expense.dart';
import 'package:final_project/expense_data/cubit_data.dart';
import 'package:final_project/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseDetails extends StatelessWidget {
  final Expense expense;

  const ExpenseDetails({
    Key? key,
    required this.expense,
  }) : super(key: key);

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
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Text(
                expense.title,
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Expense Amount'),
                  Text('${expense.amount} \$'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Date:'),
                  Text(expense.date),
                ],
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    MaterialButton(
                      padding: EdgeInsets.zero,
                      color: green,
                      shape: const CircleBorder(),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Delete Alert'),
                              content: const Text(
                                'Are you sure?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'No',
                                    style: TextStyle(
                                      color: blackText,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.red),
                                    foregroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);

                                    BlocProvider.of<ExpenseDataCubit>(context)
                                        .delete(expense.id);

                                    Navigator.pop(context);

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          '${expense.title} deleted.',
                                        ),
                                        backgroundColor: green,
                                      ),
                                    );
                                  },
                                  child: const Text('Yes'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
