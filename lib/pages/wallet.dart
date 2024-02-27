import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:foodappdemo/widget/app_constant.dart';

import '../widget/widget_support.dart';
import 'package:http/http.dart' as http;

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {

  Map<String, dynamic>? paymentIntent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 50),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              elevation: 2.0,
              child: Container(
                padding: EdgeInsets.only(bottom: 10),
                child: Center(
                  child: Text(
                    "Ví Tiền",
                    style: AppWidget.HeadlineTextFeildStyle(),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              decoration: BoxDecoration(color: Color(0xFFF2F2F2)),
              child: Row(
                children: [
                  Image.asset(
                    "images/wallet.png",
                    height: 50,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Ví của bạn",
                        style: AppWidget.LightTextFeildStyle(),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "\$" + "100",
                        style: AppWidget.boldTextFeildStyle(),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Nạp thêm tiền",
                  style: AppWidget.semiBoldTextFeildStyle(),
                )),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: (){
                    makePayment('100');
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFE9E2E2)),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      "\$" + "100",
                      style: AppWidget.semiBoldTextFeildStyle(),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    makePayment('500');
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFE9E2E2)),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      "\$" + "500",
                      style: AppWidget.semiBoldTextFeildStyle(),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    makePayment('1000');
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFE9E2E2)),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      "\$" + "1000",
                      style: AppWidget.semiBoldTextFeildStyle(),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    makePayment('2000');
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFFE9E2E2)),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      "\$" + "2000",
                      style: AppWidget.semiBoldTextFeildStyle(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 12),
              margin: EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              decoration: BoxDecoration(color: Color(0xFF008080),
                  borderRadius: BorderRadius.circular(8)),
              child: Center(
                child: Text(
                  "Nạp tiền",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


  Future<void> makePayment(String amount) async {
    try {
      paymentIntent = await createPaymentIntent(amount, 'USD');
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent!['client_secret'],
              style: ThemeMode.dark,
              merchantDisplayName: 'Huy'
          )).then((value) {});

      displayPaymentSheet(amount);
    } catch (e, s) {
      print('exception: $e$s');
    }
  }

  displayPaymentSheet(String amount) async {
    try {
      await Stripe.instance.presentCustomerSheet().then((value) async {
        showDialog(context: context, builder: (_) =>
            AlertDialog(
              content: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.green,),
                      Text("Mua hàng thành công")
                    ],
                  )
                ],
              ),

            ));

        paymentIntent = null;
      }).onError((error, stackTrace) {
        print('Error is: ---> $error $stackTrace');
      });

  }on StripeException catch(e){
      print('Error is:---> $e');
      showDialog(context: context, builder:(_)=> const AlertDialog(
        content: Text("Cancelled"),
      ));
    }catch (e){
      print('$e');
    }
  }
  createPaymentIntent(String amount, String currency) async{
    try{
      Map<String,dynamic> body = {
        'amount' : calculateAmount(amount),
        'currency' : currency,
        'payment_method_types[]':'card',
      };
      var response= await http.post(
        Uri.parse("http://api.stripe.com/v1/payment_intents"),
        headers: {
          'Authorization':'Bearer $secretKey',
          'Content-Type':'application/x-www-form-urlencoded'
        },
        body: body,
      );
      print('Payment Intent Body->>> ${response.body.toString()}');
      return jsonDecode(response.body);

    }catch(err){
      print('err charging user : ${err.toString()}');
    }
  }

  calculateAmount(String amount){
    final calculatedAmount=(int.parse(amount)*100);

    return calculatedAmount.toString();
  }

}
