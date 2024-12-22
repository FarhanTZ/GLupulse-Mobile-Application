import 'package:finpro/features/auth/presentation/components/my_buttom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

import 'delivery_progres_pages.dart';

class PaymentPages extends StatefulWidget {
  const PaymentPages({super.key});

  @override
  State<PaymentPages> createState() => _PaymentPagesState();
}

class _PaymentPagesState extends State<PaymentPages> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  //user wants to pay
  void userTappedPay(){
    if (formKey.currentState!.validate()){
      //only show dialog if form is valid
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Confirm Payment"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text("Card Number: $cardNumber"),
                Text("Expiry Date: $expiryDate"),
                Text("Card Holder name: $cardHolderName"),
                Text("CVV: $cvvCode"),
              ],
            ),
          ),
          actions: [
            //cancel buttom
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
              ),

            //yes buttom
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DeliveryProgresPages()
                ),
              );
              },
              child: const Text("Yes"),
              )
          ],
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey.shade700,
        title: const Text("Checkout"),
      ),
      body: Column(
        children: [
          // Credit Card
          CreditCardWidget(
          cardNumber: cardNumber,
          expiryDate: expiryDate,
          cardHolderName: cardHolderName,
          cvvCode: cvvCode,
          showBackView: isCvvFocused,
          onCreditCardWidgetChange: (p0) {},
          ),

          //Credit Card form
          CreditCardForm(
            cardNumber: cardNumber, 
            expiryDate: expiryDate, 
            cardHolderName: cardHolderName, 
            cvvCode: cvvCode, 
            onCreditCardModelChange: (data){
              setState(() {
                cardNumber = data.cardNumber;
                expiryDate = data.expiryDate;
                cardHolderName = data.cardHolderName;
                cvvCode = data.cvvCode;
              });
            }, 
            formKey: formKey,
            themeColor: Colors.blue,
            ),


            const Spacer(),

            MyButtom(
              onTap: userTappedPay,
              text: "Pay now",
            ),

            const SizedBox(height: 20),
        ],
      ),
    );
  }
}