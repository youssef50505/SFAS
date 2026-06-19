import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:remixicon/remixicon.dart';


class AppBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabSelected;

  const AppBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    final items = [
      {'icon': Remix.dashboard_line, 'activeIcon': Remix.dashboard_fill, 'label': 'Dashboard'},
      {'icon': Remix.money_dollar_circle_line, 'activeIcon': Remix.money_dollar_circle_fill, 'label': 'Funds'},
      {'icon': Remix.receipt_line, 'activeIcon': Remix.receipt_fill, 'label': 'Bills'},
      {'icon': Remix.exchange_dollar_line, 'activeIcon': Remix.exchange_dollar_fill, 'label': 'Collections'},
      {'icon': Remix.file_chart_line, 'activeIcon': Remix.file_chart_fill, 'label': 'Reports'},
    ];

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (index) {
              final isSelected = currentIndex == index;
              final item = items[index];

              return InkWell(
                onTap: () => onTabSelected(index),
                borderRadius: BorderRadius.circular(16),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: EdgeInsets.symmetric(
                    horizontal: isSelected ? 20.0 : 12.0,
                    vertical: 12.0,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? theme.colorScheme.primary.withValues(alpha: 0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isSelected ? item['activeIcon'] as IconData : item['icon'] as IconData,
                        color: isSelected ? theme.colorScheme.primary : Colors.grey,
                      ).animate(target: isSelected ? 1 : 0).scale(begin: const Offset(0.9, 0.9), end: const Offset(1.1, 1.1)),
                      if (isSelected) ...[
                        const SizedBox(width: 8),
                        Text(
                          item['label'] as String,
                          style: TextStyle(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ).animate().fadeIn().slideX(begin: 0.2),
                      ]
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
