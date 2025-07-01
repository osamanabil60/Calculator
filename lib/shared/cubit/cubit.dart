// import 'package:bloc/bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:calculator/shared/cubit/states.dart';
//
//
// class Countercubit extends Cubit<CounterStates>
// {
//   Countercubit() : super(CounterInitailState());
//   // to call object from this class in all app   we use BlocProvider.of(context) like we create an object in main.dart
// static Countercubit get(context) => BlocProvider.of(context);
//
//   var counter1 ;
//   var counter2 ;
//   var counter3 ;
//   var counter4 ;
//   var counter5 ;
//   var counter6 ;
//   var counter7 ;
//   var counter8 ;
//   var counter9 ;
//   var counter10 ;
//   var counter11 ;
//   var counter12 ;
//   var result ;
//
//
// void minus()
// {
//   result = (counter1-counter2) as double ;
//   // to emit => send a state like set state in flutter
//   emit(CounterMinusState(result));
// }
// void plus()
// {
//   result = (counter1+counter2) as double ;
//   emit(CounterPlusState(result));
// }
//
// void multi()
// {
//     result = (counter1*counter2) as double ;
//     emit(Multi());
// }
// void div()
// {
//     result = (counter1/counter2) as double ;
//     emit(Div());
// }
// }//end of class
//
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'states.dart';

class CalculatorCubit extends Cubit<CalculatorState> {
  CalculatorCubit() : super(CalculatorInitialState());

  static CalculatorCubit get(context) => BlocProvider.of(context);

  String currentInput = '0';
  String storedInput = '';
  String operation = '';
  bool shouldResetInput = false;

  void inputNumber(String number) {
    if (shouldResetInput) {
      currentInput = '0';
      shouldResetInput = false;
    }

    if (currentInput == '0') {
      currentInput = number;
    } else {
      currentInput += number;
    }
    emit(NumberInputState(currentInput));
  }

  void inputDecimal() {
    if (shouldResetInput) {
      currentInput = '0';
      shouldResetInput = false;
    }

    if (!currentInput.contains('.')) {
      currentInput += '.';
      emit(NumberInputState(currentInput));
    }
  }

  void setOperation(String op) {
    if (storedInput.isNotEmpty && operation.isNotEmpty && !shouldResetInput) {
      calculate();
    }
    storedInput = currentInput;
    operation = op;
    shouldResetInput = true;
    emit(NumberInputState(currentInput));
  }

  void calculate() {
    if (storedInput.isEmpty || operation.isEmpty) return;

    try {
      double num1 = double.parse(storedInput);
      double num2 = double.parse(currentInput);
      double result;

      switch (operation) {
        case '+':
          result = num1 + num2;
          break;
        case '-':
          result = num1 - num2;
          break;
        case '×':
          result = num1 * num2;
          break;
        case '÷':
          if (num2 == 0) {
            emit(ErrorState('Cannot divide by zero'));
            return;
          }
          result = num1 / num2;
          break;
        default:
          return;
      }

      currentInput = result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 2);
      storedInput = '';
      operation = '';
      shouldResetInput = true;
      emit(CalculationResultState(currentInput));
    } catch (e) {
      emit(ErrorState('Calculation error'));
    }
  }

  void clear() {
    currentInput = '0';
    storedInput = '';
    operation = '';
    shouldResetInput = false;
    emit(CalculatorInitialState());
  }

  void delete() {
    if (currentInput.length > 1) {
      currentInput = currentInput.substring(0, currentInput.length - 1);
    } else {
      currentInput = '0';
    }
    emit(NumberInputState(currentInput));
  }
}