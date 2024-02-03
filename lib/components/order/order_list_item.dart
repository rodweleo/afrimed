import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../models/OrderProduct.dart';

class OrderListItem extends StatelessWidget {
  const OrderListItem({super.key, required this.orderProduct});

  final OrderProduct orderProduct;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(7.5),
        child: CachedNetworkImage(
          placeholder: (context, url) => const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          height: 50,
          width: 50,
          imageUrl:
          orderProduct.thumbnail,
          fit: BoxFit.fill,
        ),
      ),
      title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(orderProduct.name, style: TextStyle(color: Colors.black.withOpacity(0.75), fontSize: MediaQuery.of(context).size.height * 0.02)),
          Text('KSh ${orderProduct.totalAmount.toString()}', style: TextStyle(color: Colors.black, fontSize: MediaQuery.of(context).size.height * 0.02, fontWeight: FontWeight.bold),),
        ]
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              Text('Qty: ${orderProduct.orderQuantity}', style: TextStyle(color: Colors.black.withOpacity(0.5)))
            ],
          ),
        ],
      ),
      onTap: () {

      },
    );
  }
}
