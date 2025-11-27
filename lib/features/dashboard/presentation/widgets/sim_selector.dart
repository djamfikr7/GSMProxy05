import 'package:flutter/material.dart';
import '../../../../components/components.dart';
import '../../../../design/tokens.dart';

class SimSlotSelector extends StatefulWidget {
  final int simCount;
  final int selectedSlot;
  final Function(int) onSlotSelected;

  const SimSlotSelector({
    super.key,
    this.simCount = 2,
    this.selectedSlot = 0,
    required this.onSlotSelected,
  });

  @override
  State<SimSlotSelector> createState() => _SimSlotSelectorState();
}

class _SimSlotSelectorState extends State<SimSlotSelector> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GlassCard(
      padding: const EdgeInsets.all(AppTokens.space2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(widget.simCount, (index) {
          final isSelected = widget.selectedSlot == index;
          return GestureDetector(
            onTap: () => widget.onSlotSelected(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(
                horizontal: AppTokens.space4,
                vertical: AppTokens.space2,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? theme.colorScheme.primary
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(AppTokens.radiusSm),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.sim_card_rounded,
                    size: 16,
                    color: isSelected
                        ? theme.colorScheme.onPrimary
                        : theme.colorScheme.onSurface,
                  ),
                  const SizedBox(width: AppTokens.space2),
                  Text(
                    'SIM ${index + 1}',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: isSelected
                          ? theme.colorScheme.onPrimary
                          : theme.colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
