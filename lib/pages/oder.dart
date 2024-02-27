import 'package:flutter/material.dart';
import 'package:foodappdemo/widget/widget_support.dart';
class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Center(child: Text("Order",style: AppWidget.boldTextFeildStyle(),)),);
  }
}
