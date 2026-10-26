import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ShareProductButton extends StatelessWidget {
  final String productId;

  const ShareProductButton({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final String productLink =
            "https://huma-volve-ecommerce-17311.web.app/products/$productId";
        final String shareMessage = " Look at this product: $productLink";
        await SharePlus.instance.share(
          ShareParams(
            text: shareMessage,
            subject: "Checkout this product on Huma Volve",
          ),
        );
      },
      icon: Icon(Icons.share),
    );
  }
}
