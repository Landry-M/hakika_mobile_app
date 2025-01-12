import 'package:flutter/material.dart';
import 'package:hakika/provider/paiement_provider.dart';
import 'package:provider/provider.dart';

class PaymentMethodButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final String value;
  final bool selected;
  final ValueChanged<String?> onChanged;

  const PaymentMethodButton({
    super.key,
    required this.label,
    required this.icon,
    required this.value,
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        context.read<PaiementProvider>().setPaymentMethod(value);
      },
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor:
            context.watch<PaiementProvider>().paymentMethod == value
                ? Colors.blueAccent
                : Colors.grey[200],
        foregroundColor:
            context.watch<PaiementProvider>().paymentMethod == value
                ? Colors.white
                : Colors.black,
      ),
    );
  }
}
