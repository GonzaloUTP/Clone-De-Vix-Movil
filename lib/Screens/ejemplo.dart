import 'dart:io';
import 'package:flutter/material.dart';
import 'payment_config.dart';
import 'package:pay/pay.dart';

class Ejemplo extends StatefulWidget {
  const Ejemplo({super.key});

  @override
  State<Ejemplo> createState() => _EjemploState();
}

class _EjemploState extends State<Ejemplo> {
  String os = Platform.operatingSystem;

  var applePayButton = ApplePayButton(
    paymentConfiguration: PaymentConfiguration.fromJsonString(defaultApplePay),
    paymentItems: const [
      PaymentItem(
        label: 'item a',
        amount: '0.01',
        status: PaymentItemStatus.final_price,
      ),
        PaymentItem(
        label: 'item b',
        amount: '0.01',
        status: PaymentItemStatus.final_price,
      ),
    ],
    style: ApplePayButtonStyle.black,
    width: double.infinity,
    height: 50,
    type: ApplePayButtonType.buy,
    margin: const EdgeInsets.only(top: 15.0),
    onPaymentResult: (result) => debugPrint('Resultado $result'),
    loadingIndicator: const Center(child: CircularProgressIndicator(),),
    );

    var googlePayButton = GooglePayButton(
      paymentConfiguration: PaymentConfiguration.fromJsonString(defaultGooglePay),
      paymentItems: const [
        PaymentItem(
        label: 'item b',
        amount: '0.01',
        status: PaymentItemStatus.final_price,
      ),
      ],
      width: double.infinity,
      type: GooglePayButtonType.pay,
      margin: const EdgeInsets.only(top: 15.0),
      onPaymentResult: (result) => debugPrint('Resultado $result'),
      loadingIndicator: const Center(child: CircularProgressIndicator(),),
    );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Platform.isIOS ? applePayButton : googlePayButton,
          )
        ],
      ),
    );
  }
}
