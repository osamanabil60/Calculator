import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared/cubit/cubit.dart';
import '../shared/cubit/states.dart';

class CalculatorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CalculatorCubit(),
      child: BlocConsumer<CalculatorCubit, CalculatorState>(
        listener: (context, state) {
          if (state is ErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          final cubit = CalculatorCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.black,
            body: SafeArea(
              child: Column(
                children: [
                  // Display
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      alignment: Alignment.bottomRight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${cubit.storedInput} ${cubit.operation}',
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            cubit.currentInput,
                            style: TextStyle(
                              fontSize: 48,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Buttons
                  Expanded(
                    flex: 4,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Memory row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [

                            ],
                          ),
                          // First row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildButton('C', Colors.grey[850]!, () => cubit.clear()),
                              _buildButton('%', Colors.grey[800]!, () => cubit.inputNumber('%')),
                              _buildButton('×', Colors.amber[700]!, () => cubit.setOperation('×')),
                              _buildButton('⌫', Colors.amber[700]!, () => cubit.delete()),
                            ],
                          ),
                          // Second row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildButton('7', Colors.grey[800]!, () => cubit.inputNumber('7')),
                              _buildButton('8', Colors.grey[800]!, () => cubit.inputNumber('8')),
                              _buildButton('9', Colors.grey[800]!, () => cubit.inputNumber('9')),
                              _buildButton('÷', Colors.amber[700]!, () => cubit.setOperation('÷')),
                            ],
                          ),
                          // Third row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildButton('4', Colors.grey[800]!, () => cubit.inputNumber('4')),
                              _buildButton('5', Colors.grey[800]!, () => cubit.inputNumber('5')),
                              _buildButton('6', Colors.grey[800]!, () => cubit.inputNumber('6')),
                              _buildButton('-', Colors.amber[700]!, () => cubit.setOperation('-')),
                            ],
                          ),
                          // Fourth row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildButton('1', Colors.grey[800]!, () => cubit.inputNumber('1')),
                              _buildButton('2', Colors.grey[800]!, () => cubit.inputNumber('2')),
                              _buildButton('3', Colors.grey[800]!, () => cubit.inputNumber('3')),
                              _buildButton('+', Colors.amber[700]!, () => cubit.setOperation('+')),
                            ],
                          ),
                          // Fifth row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildButton('0', Colors.grey[800]!, () => cubit.inputNumber('0')),
                              _buildButton('.', Colors.grey[800]!, () => cubit.inputDecimal()),
                              _eqalButton('=', Colors.amber[700]!, () => cubit.calculate()),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildButton(String text, Color color, VoidCallback onPressed) {
    return SizedBox(
      width: 64,
      height: 64,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: CircleBorder(),
          padding: EdgeInsets.zero,
          elevation: 2,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildMemoryButton(String text, Color color) {
    return SizedBox(
      width: 64,
      height: 64,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: color,
          shape: CircleBorder(),
          padding: EdgeInsets.zero,
        ),
        onPressed: () {},
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }



  Widget _eqalButton(String text, Color color, VoidCallback onPressed) {
    return Container(
      width: 140,
      height: 64,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10),
          elevation: 2,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}