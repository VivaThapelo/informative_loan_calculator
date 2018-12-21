import 'package:informative_loan_calculator/Loan.dart';

abstract class Calc {
//static final RoundingMode MODE = RoundingMode.HALF_UP;
//static final int SCALE = 8;
  void calculate(Loan loan);
}
