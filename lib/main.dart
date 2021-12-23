// Copyright (c) 2021 Razeware LLC

// Permission is hereby granted, free of charge, to any person
// obtaining a copy of this software and associated documentation
// files (the "Software"), to deal in the Software without
// restriction, including without limitation the rights to use,
// copy, modify, merge, publish, distribute, sublicense, and/or
// sell copies of the Software, and to permit persons to whom
// the Software is furnished to do so, subject to the following
// conditions:

// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.

// Notwithstanding the foregoing, you may not use, copy, modify,
// merge, publish, distribute, sublicense, create a derivative work,
// and/or sell copies of the Software in any work that is designed,
// intended, or marketed for pedagogical or instructional purposes
// related to programming, coding, application development, or
// information technology. Permission for such use, copying,
// modification, merger, publication, distribution, sublicensing,
// creation of derivative works, or sale is expressly withheld.

// This project and source code may use libraries or frameworks
// that are released under various Open-Source licenses. Use of
// those libraries and frameworks are governed by their own
// individual licenses.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
// HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
// DEALINGS IN THE SOFTWARE.

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            title: const Text('tipCalculator'),
          ),
          body: const SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.all(20.0),
            child: TipCalculator(),
          ))),
    );
  }
}

class TipCalculator extends StatefulWidget {
  const TipCalculator({Key? key}) : super(key: key);

  @override
  _TipCalculatorState createState() => _TipCalculatorState();
}

class _TipCalculatorState extends State<TipCalculator> {
  double _tipAmount = 0;
  double _totalAmount = 0;

  TextEditingController billTextEditingController =
      TextEditingController(text: '0');
  TextEditingController tipTextEditingController =
      TextEditingController(text: '15');

  TextStyle mTextStyle1 = const TextStyle(fontSize: 20);
  TextStyle mTextStyle2 = const TextStyle(fontSize: 15);

  //1
  double _calculateTipAmount(double tipPercentage, double bill) {
    return (tipPercentage / 100) * bill;
  }

  //2
  double _calculateTotalAmount(double tipAmount, double bill) {
    return tipAmount + bill;
  }

  double _getValueFromTextEditingController(
      TextEditingController textEditingController) {
    return double.parse(textEditingController.text);
  }

  void _calculateBillAndTip() {
    final bill = _getValueFromTextEditingController(billTextEditingController);
    final tipPercentage =
        _getValueFromTextEditingController(tipTextEditingController);

    setState(() {
      _tipAmount = _calculateTipAmount(tipPercentage, bill);
      _totalAmount = _calculateTotalAmount(_tipAmount, bill);
    });
  }

  @override
  void initState() {
    //code goes here
    //1
    billTextEditingController.addListener(() {
      _calculateBillAndTip();
    });
    //2
    tipTextEditingController.addListener(() {
      _calculateBillAndTip();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 50,
        ),
        MTextField(
            label: ' Bill Amount', controller: billTextEditingController),
        const SizedBox(
          height: 50,
        ),
        MTextField(
            label: 'Tip Percentage', controller: tipTextEditingController),
        const SizedBox(
          height: 50,
        ),
        //1
        Text(
          'Bill Amount',
          style: mTextStyle1,
        ),
        const SizedBox(
          height: 10,
        ),
        //2
        Text(
          '\$${_tipAmount}',
          style: mTextStyle2,
        ),
        const SizedBox(
          height: 25,
        ),
        //3
        Text(
          'Total Amount',
          style: mTextStyle1,
        ),
        const SizedBox(
          height: 10,
        ),
        //4
        Text(
          '\$${_totalAmount}',
          style: mTextStyle2,
        ),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }
}

class MTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  const MTextField({Key? key, required this.label, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        hintText: label,
        labelText: label,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      controller: controller,
    );
  }
}
