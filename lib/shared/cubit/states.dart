abstract class CalculatorState {}

class CalculatorInitialState extends CalculatorState {}

class NumberInputState extends CalculatorState {
  final String display;
  NumberInputState(this.display);
}

class CalculationResultState extends CalculatorState {
  final String result;
  CalculationResultState(this.result);
}

class ErrorState extends CalculatorState {
  final String message;
  ErrorState(this.message);
}