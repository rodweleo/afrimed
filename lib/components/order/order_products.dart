import 'package:AfriMed/components/order/order_list_item.dart';
import 'package:flutter/material.dart';
import '../../models/OrderProduct.dart';

class OrderProducts extends StatelessWidget {
  const OrderProducts({super.key, required this.orderProducts});

  final List<OrderProduct> orderProducts;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        SizedBox(
          height: 150,
          child: ListView.builder(
              itemCount: orderProducts.length,
              itemBuilder: (context, index){
                return OrderListItem(orderProduct: orderProducts[index],);
              }),
        ),
        const Divider(),
      ],
    );
  }
}
