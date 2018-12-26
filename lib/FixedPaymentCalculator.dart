import 'AbstractCalc.dart';
import 'Loan.dart';
import 'Payment.dart';

class FixedPaymentCalculator extends AbstractCalc {
  void calculate(Loan loan) {
    double currentAmount = calculateAmountWithDownPayment(loan);
    loan.setResiduePayment(getResiduePayment(loan));
    bool hasResidue = loan.getResiduePayment().compareTo(0) > 0;

    addDisposableCommission(loan, currentAmount);

    double interestMonthly = loan.getInterest() / 1200;
    double monthlyAmount = loan.getFixedPayment();

    double ma = monthlyAmount;
    double interest = 0;
    double payment = 0;
    int i = 0;

    if (loan.getAmount() / loan.getFixedPayment().toInt() > 1000) {
      throw new Exception(
          "Too small fixed payment part. Count of payments is over 1000 and mobile device can't calculate too big periods.");
    }
    List<Payment> payments = new List<Payment>();
    while (currentAmount.compareTo(loan.getResiduePayment()) > 0) {
      if (currentAmount.compareTo(ma) < 0) {
        ma = currentAmount;
      }

      interest = currentAmount * interestMonthly;
      payment = interest - ma;

      Payment p = new Payment();
      p.setNr(i + 1);
      p.setInterest(interest);
      p.setPrincipal(ma);
      p.setBalance(currentAmount);

      addPaymentWithCommission(loan, p, payment);

      payments.add(p);

      currentAmount = currentAmount - ma;
      i++;
    }
    if (hasResidue) {
      interest = currentAmount * interestMonthly;
      payment = currentAmount + interest;
      ma = currentAmount;

      Payment p = new Payment();
      p.setNr(i + 1);
      p.setInterest(interest);
      p.setPrincipal(ma);
      p.setBalance(currentAmount);

      addPaymentWithCommission(loan, p, payment);

      payments.add(p);

      currentAmount = currentAmount - ma;
      i++;
    }

    loan.setPeriod(i);
    loan.setPayments(payments);
    loan.setEffectiveInterestRate(calculateEffectiveInterestRate(loan));
  }
}
