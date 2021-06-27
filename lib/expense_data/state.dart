part of 'cubit_data.dart';

abstract class ExpenseDataState extends Equatable {
  const ExpenseDataState();
}

class ExpenseDataInitial extends ExpenseDataState {
  @override
  List<Object> get props => [];
}

class ExpenseDataLoaded extends ExpenseDataState {
  final List<Expense> expenses;

  const ExpenseDataLoaded({
    required this.expenses,
  });

  @override
  List<Object?> get props => [expenses];
}

class ExpenseDataError extends ExpenseDataState {
  final String message;

  const ExpenseDataError({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
