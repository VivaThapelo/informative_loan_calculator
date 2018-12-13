import 'package:flutter/material.dart';

import 'LoanObjectClass.dart';

const int ANNUITY = 0, DIFFERENTIATED = 1, FIXED_PAYMENTS = 2;
LoanObjectClass loaned = new LoanObjectClass();
String downType = "%", lastType = "%", monthlyType = "%", disposableType = "%";
int selectedLoan = 0, selectedInterestType = 0;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
        primaryColorBrightness: Brightness.light,
        backgroundColor: Colors.grey.shade900,
      ),
      home: MyHomePage(title: 'Informative Loan Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> _askedToLead() async {
    switch (await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Form Data'),
            children: <Widget>[
              new Center(
                child: new Text(loaned.loanAmount.toString() +
                    '\n' +
                    loaned.loanInterestPercentage.toString() +
                    '\n' +
                    loaned.loanDisposableCommission.toString()),
              ),

              /* SimpleDialogOption(
                onPressed: () { Navigator.pop(context, "close"); },
                child: const Text('Treasury department'),
              ),
              SimpleDialogOption(
                onPressed: () { Navigator.pop(context, "remove"); },
                child: const Text('State department'),
              ),*/
            ],
          );
        })) {
      case "close":
        new Text('close');
        break;
      case "remove":
        new Text('remove');
        break;
    }
  }

  TextEditingController _amountController = new TextEditingController();
  TextEditingController _interestController = new TextEditingController();
  TextEditingController _fixedPaymentController = new TextEditingController();
  TextEditingController _downPaymentController = new TextEditingController();
  TextEditingController _disposableCommissionController =
      new TextEditingController();
  TextEditingController _monthlyCommissionController =
      new TextEditingController();
  TextEditingController _lastPaymentController = new TextEditingController();

  clearForm() {
    setState(() {
      _amountController.text = '';
      _interestController.text = '';
      _fixedPaymentController.text = '';
      _downPaymentController.text = '';
      _disposableCommissionController.text = '';
      _monthlyCommissionController.text = '';
      _lastPaymentController.text = '';
      downType = "%";
      lastType = "%";
      monthlyType = "%";
      disposableType = "%";
      selectedLoan = 0;
      selectedInterestType = 0;
    });
  }

  clearAll() {
    clearForm(); // clearing the fields
    loaned.clearObject(); // clearing the class
  }

  onDownPaymentChange() {
    if (_downPaymentController.text.isNotEmpty) {
      if (downType == ".00") {
        loaned.setDownPayment(
            double.parse(_downPaymentController.text.toString()));
      } else {
        loaned.setDownPayment(
            (double.parse(_downPaymentController.text.toString()) / 100) *
                double.parse(_amountController.text.toString()));
      }
    }
  }

  onDisposableChange() {
    if (_disposableCommissionController.text.isNotEmpty) {
      if (disposableType == ".00") {
        loaned.setDisposableCommission(
            double.parse(_disposableCommissionController.text.toString()));
      } else {
        loaned.setDisposableCommission(
            (double.parse(_disposableCommissionController.text.toString()) /
                    100) *
                double.parse(_amountController.text.toString()));
      }
    }
  }

  onMonthlyChange() {
    if (_monthlyCommissionController.text.isNotEmpty) {
      if (monthlyType == ".00") {
        print(double.parse(_monthlyCommissionController.text.toString()));
        loaned.setMonthlyCommission(
            double.parse(_monthlyCommissionController.text.toString()));
      } else {
        loaned.setMonthlyCommission(
            (double.parse(_monthlyCommissionController.text.toString()) / 100) *
                double.parse(_amountController.text.toString()));
      }
    }
  }

  onLastChange() {
    if (_lastPaymentController.text.isNotEmpty) {
      if (lastType == ".00") {
        loaned.setLastPayment(
            double.parse(_lastPaymentController.text.toString()));
      } else {
        loaned.setLastPayment(
            (double.parse(_lastPaymentController.text.toString()) / 100) *
                double.parse(_amountController.text.toString()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        actions: <Widget>[
          new RawMaterialButton(
              onPressed: () {
                clearAll();
              },
              child: new Text(
                'ClearAll',
                style: new TextStyle(fontSize: 18.0),
              ))
        ],
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        bottom: new PreferredSize(
            child: new ClipRRect(
              borderRadius: new BorderRadius.all(Radius.circular(16.0)),
              child: new Container(
                color: Colors.white,
                child: new DropdownButtonHideUnderline(
                    child: new DropdownButton(
                  value: selectedLoan,
                  items: [
                    new DropdownMenuItem(
                      child: new Text(
                        'Annuity Payments',
                        style: new TextStyle(fontSize: 18.0),
                      ),
                      value: 0,
                    ),
                    new DropdownMenuItem(
                      child: new Text(
                        'Differentiated',
                        style: new TextStyle(fontSize: 18.0),
                      ),
                      value: 1,
                    ),
                    new DropdownMenuItem(
                        child: new Text(
                          'Fixed Payments',
                          style: new TextStyle(fontSize: 18.0),
                        ),
                        value: 2)
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedLoan = value;
                    });
                  },
                  isExpanded: true,
                  hint: new Text(
                    'Select option:',
                    style: new TextStyle(fontSize: 18.0),
                  ),
                )),
                margin:
                    new EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                padding: new EdgeInsets.only(left: 16.0, right: 16.0),
              ),
            ),
            preferredSize: Size.fromHeight(56.0)),
        title: Text(widget.title),
      ),
      body: new Container(
        padding: new EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
        child: new Column(children: [
          new TextField(
            decoration: new InputDecoration(
                labelText: "Loan Amount(R)",
                hintText: "e.g. 2000",
                helperText: "amount > 0"),
            controller: _amountController,
            onChanged: (amount) {
              loaned.setAmount(double.parse(amount));
            },
          ),
          new Row(
            children: <Widget>[
              new Flexible(
                flex: 3,
                child: new DropdownButton(
                  value: selectedInterestType,
                  items: [
                    new DropdownMenuItem(
                      child: new Text(
                        'Nominal',
                        style: new TextStyle(fontSize: 18.0),
                      ),
                      value: 0,
                    ),
                    new DropdownMenuItem(
                      child: new Text(
                        'Effective',
                        style: new TextStyle(fontSize: 18.0),
                      ),
                      value: 1,
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedInterestType = value;
                    });
                  },
                  isExpanded: true,
                  hint: new Text(
                    'Type:',
                    style: new TextStyle(
                      fontSize: 18.0,
                      height: 3.8,
                    ),
                  ),
                ),
              ),
              new Flexible(
                flex: 7,
                child: new TextField(
                  controller: null,
                  decoration: new InputDecoration(
                    labelText: "Interest Rate(%)",
                    hintText: "5",
                    // helperText: "interest amount"
                  ),
                  onChanged: (interestPercentage) {
                    loaned.setInterestPercentage(
                        double.parse(interestPercentage));
                  },
                ),
              ),
            ],
          ),
          new TextField(
            decoration: new InputDecoration(
                labelText: "Fixed Payment",
                hintText: "e.g. 500",
                helperText: "amount > 0"),
            controller: _fixedPaymentController,
            onChanged: (fixedPayment) {
              loaned.setFixedPayment(double.parse(fixedPayment));
            },
          ),

          new Row(
            children: <Widget>[
              new Flexible(
                flex: 1,
                child: new Text(
                  'Period:        ',
                  style: new TextStyle(fontSize: 18.0),
                ),
              ),
              new Flexible(
                flex: 3,
                child: new DropdownButton(
                  value: loaned.loanPeriodYears,
                  items: [
                    new DropdownMenuItem(
                      child: new Text(
                        '0',
                        style: new TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      value: 0,
                    ),
                    new DropdownMenuItem(
                      child: new Text(
                        '1',
                        style: new TextStyle(fontSize: 18.0),
                      ),
                      value: 1,
                    ),
                    new DropdownMenuItem(
                      child: new Text(
                        '2',
                        style: new TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      value: 2,
                    ),
                    new DropdownMenuItem(
                      child: new Text(
                        '3',
                        style: new TextStyle(fontSize: 18.0),
                      ),
                      value: 3,
                    ),
                    new DropdownMenuItem(
                      child: new Text(
                        '4',
                        style: new TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      value: 4,
                    ),
                    new DropdownMenuItem(
                      child: new Text(
                        '5',
                        style: new TextStyle(fontSize: 18.0),
                      ),
                      value: 5,
                    ),
                    new DropdownMenuItem(
                      child: new Text(
                        '6',
                        style: new TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      value: 6,
                    ),
                    new DropdownMenuItem(
                      child: new Text(
                        '7',
                        style: new TextStyle(fontSize: 18.0),
                      ),
                      value: 7,
                    ),
                    new DropdownMenuItem(
                      child: new Text(
                        '8',
                        style: new TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      value: 8,
                    ),
                    new DropdownMenuItem(
                      child: new Text(
                        '9',
                        style: new TextStyle(fontSize: 18.0),
                      ),
                      value: 9,
                    ),
                    new DropdownMenuItem(
                      child: new Text(
                        '10',
                        style: new TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      value: 10,
                    ),
                    new DropdownMenuItem(
                      child: new Text(
                        '11',
                        style: new TextStyle(fontSize: 18.0),
                      ),
                      value: 11,
                    ),
                  ],
                  onChanged: (periodYears) {
                    setState(() {
                      loaned.setPeriodYears(periodYears);
                    });
                  },
                  isExpanded: true,
                  hint: new Text(
                    'Years',
                    style: new TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
              new Flexible(
                flex: 3,
                child: new DropdownButton(
                  value: loaned.loanPeriodMonths,
                  items: [
                    new DropdownMenuItem(
                      child: new Text(
                        '0',
                        style: new TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      value: 0,
                    ),
                    new DropdownMenuItem(
                      child: new Text(
                        '1',
                        style: new TextStyle(fontSize: 18.0),
                      ),
                      value: 1,
                    ),
                    new DropdownMenuItem(
                      child: new Text(
                        '2',
                        style: new TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      value: 2,
                    ),
                    new DropdownMenuItem(
                      child: new Text(
                        '3',
                        style: new TextStyle(fontSize: 18.0),
                      ),
                      value: 3,
                    ),
                    new DropdownMenuItem(
                      child: new Text(
                        '4',
                        style: new TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      value: 4,
                    ),
                    new DropdownMenuItem(
                      child: new Text(
                        '5',
                        style: new TextStyle(fontSize: 18.0),
                      ),
                      value: 5,
                    ),
                    new DropdownMenuItem(
                      child: new Text(
                        '6',
                        style: new TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      value: 6,
                    ),
                    new DropdownMenuItem(
                      child: new Text(
                        '7',
                        style: new TextStyle(fontSize: 18.0),
                      ),
                      value: 7,
                    ),
                    new DropdownMenuItem(
                      child: new Text(
                        '8',
                        style: new TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      value: 8,
                    ),
                    new DropdownMenuItem(
                      child: new Text(
                        '9',
                        style: new TextStyle(fontSize: 18.0),
                      ),
                      value: 9,
                    ),
                    new DropdownMenuItem(
                      child: new Text(
                        '10',
                        style: new TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      value: 10,
                    ),
                    new DropdownMenuItem(
                      child: new Text(
                        '11',
                        style: new TextStyle(fontSize: 18.0),
                      ),
                      value: 11,
                    ),
                  ],
                  onChanged: (periodMonths) {
                    setState(() {
                      loaned.setPeriodMonths(periodMonths);
                    });
                  },
                  isExpanded: true,
                  hint: new Text(
                    'Months',
                    style: new TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
            ],
          ),

          ///// the ones at the bottom ---- add magin/padding at top by 16.0

          // Down Payment
          new Row(
            children: <Widget>[
              new Flexible(
                flex: 8,
                child: new TextField(
                  controller: _downPaymentController,
                  decoration: new InputDecoration(
                      labelText: "Down Payment",
                      hintText: "e.g. 400",
                      helperText: "value or percentage from loan amount"),
                  onChanged: (downPayment) {
                    onDownPaymentChange(); // executes the storing code
                  },
                ),
              ),
              new Flexible(
                flex: 2,
                child: new DropdownButton(
                  value: downType,
                  items: [
                    new DropdownMenuItem(
                      child: new Text(
                        '%',
                        style: new TextStyle(fontSize: 18.0),
                      ),
                      value: "%",
                    ),
                    new DropdownMenuItem(
                      child: new Text(
                        '.00',
                        style: new TextStyle(fontSize: 18.0),
                      ),
                      value: ".00",
                    ),
                  ],
                  onChanged: (type) {
                    setState(() {
                      downType = type;
                      onDownPaymentChange();
                    });
                    // executes the storing code
                  },
                  isExpanded: true,
                ),
              ),
            ],
          ),

          // Disposable Commission
          new Row(
            children: <Widget>[
              new Flexible(
                flex: 8,
                child: new TextField(
                  controller: null,
                  decoration: new InputDecoration(
                      labelText: "Disposable Commission",
                      hintText: "e.g. 200",
                      helperText: "value or percentage from loan amount"),
                  onChanged: (disposableCommission) {
                    onDisposableChange();
                  },
                ),
              ),
              new Flexible(
                flex: 2,
                child: new DropdownButton(
                  value: disposableType,
                  items: [
                    new DropdownMenuItem(
                      child: new Text(
                        '%',
                        style: new TextStyle(fontSize: 18.0),
                      ),
                      value: "%",
                    ),
                    new DropdownMenuItem(
                      child: new Text(
                        '.00',
                        style: new TextStyle(fontSize: 18.0),
                      ),
                      value: ".00",
                    ),
                  ],
                  onChanged: (value) {
                    onDisposableChange();
                    setState(() {
                      disposableType = value;
                    });
                  },
                  isExpanded: true,
                ),
              ),
            ],
          ),

          // Monthly Commission
          new Row(
            children: <Widget>[
              new Flexible(
                flex: 8,
                child: new TextField(
                  controller: null,
                  decoration: new InputDecoration(
                      labelText: "Monthly Commission",
                      hintText: "e.g. 150",
                      helperText:
                          "value or percentage from monthly commission"),
                  onChanged: (value) {
                    onMonthlyChange();
                  },
                ),
              ),
              new Flexible(
                flex: 2,
                child: new DropdownButton(
                  value: monthlyType,
                  items: [
                    new DropdownMenuItem(
                      child: new Text(
                        '%',
                        style: new TextStyle(fontSize: 18.0),
                      ),
                      value: "%",
                    ),
                    new DropdownMenuItem(
                      child: new Text(
                        '.00',
                        style: new TextStyle(fontSize: 18.0),
                      ),
                      value: ".00",
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      monthlyType = value;
                      onMonthlyChange();
                    });
                  },
                  isExpanded: true,
                ),
              ),
            ],
          ),

          // Last Payment
          new Row(
            children: <Widget>[
              new Flexible(
                flex: 8,
                child: new TextField(
                  controller: null,
                  decoration: new InputDecoration(
                      labelText: "Last Payment",
                      hintText: "e.g. 350",
                      helperText: "value or percentage from month"),
                  onChanged: (value) {
                    onLastChange();
                  },
                ),
              ),
              new Flexible(
                flex: 2,
                child: new DropdownButton(
                  value: lastType,
                  items: [
                    new DropdownMenuItem(
                      child: new Text(
                        '%',
                        style: new TextStyle(fontSize: 18.0),
                      ),
                      value: "%",
                    ),
                    new DropdownMenuItem(
                      child: new Text(
                        '.00',
                        style: new TextStyle(fontSize: 18.0),
                      ),
                      value: ".00",
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      lastType = value;
                      onLastChange();
                    });
                  },
                  isExpanded: true,
                ),
              ),
            ],
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _askedToLead();
        },
        tooltip: 'Calculate',
        icon: Icon(Icons.done),
        label: new Text('Calculate'),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
