import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../models/insurance_company.dart';
import '../models/vehicle.dart';
import '../models/client.dart';
import '../services/premium_calculator.dart';
import '../data/insurers_data.dart';
import '../providers/calculator_provider.dart';

class ComparisonScreen extends ConsumerWidget {
  static const String routeName = 'comparison';
  
  final Client client;
  final Vehicle vehicle;
  final List<InsurerComparison>? comparisons;

  const ComparisonScreen({
    super.key,
    required this.client,
    required this.vehicle,
    this.comparisons,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    // Get comparisons (from provider or calculate)
    final comparisons = _getComparisons();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insurance Comparison'),
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Client and Vehicle Summary
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quote Summary',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Client: ${client.fullName}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onPrimaryContainer,
                  ),
                ),
                Text(
                  'Vehicle: ${vehicle.fullName}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onPrimaryContainer,
                  ),
                ),
                Text(
                  'Value: ${NumberFormat.currency(locale: 'en_KE', symbol: 'KES ').format(vehicle.value)}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onPrimaryContainer,
                  ),
                ),
              ],
            ),
          ),
          
          // Comparison List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: comparisons.length,
              itemBuilder: (context, index) {
                final comparison = comparisons[index];
                return _buildInsurerCard(context, comparison, theme);
              },
            ),
          ),
        ],
      ),
    );
  }

  List<InsurerComparison> _getComparisons() {
    if (comparisons != null) {
      return comparisons!;
    }
    
    // Fallback calculation if comparisons not provided
    final calculatedComparisons = <InsurerComparison>[];
    
    for (final insurer in InsurersData.insurers) {
      final premium = PremiumCalculator.calculatePremium(insurer, vehicle);
      calculatedComparisons.add(InsurerComparison(
        insurer: insurer,
        premium: premium,
      ));
    }
    
    // Sort by premium (ascending)
    calculatedComparisons.sort((a, b) => a.premium.compareTo(b.premium));
    
    return calculatedComparisons;
  }

  Widget _buildInsurerCard(BuildContext context, InsurerComparison comparison, ThemeData theme) {
    final colorScheme = theme.colorScheme;
    final premium = comparison.premium;
    final insurer = comparison.insurer;
    
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Insurer Header
            Row(
              children: [
                // Insurer Logo Placeholder
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.business,
                    color: colorScheme.onPrimary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        insurer.name,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Base Rate: ${(insurer.baseRate * 100).toStringAsFixed(1)}%',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                // Premium
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      NumberFormat.currency(
                        locale: 'en_KE',
                        symbol: 'KES ',
                        decimalDigits: 0,
                      ).format(premium),
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'per year',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Benefits
            Text(
              'Benefits:',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...insurer.benefits.map((benefit) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 16,
                    color: colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          benefit.title,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          benefit.description,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
            
            const SizedBox(height: 16),
            
            // Select Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _selectInsurer(context, insurer, premium),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Select This Insurer'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _selectInsurer(BuildContext context, InsuranceCompany insurer, double premium) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select ${insurer.name}?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Premium: ${NumberFormat.currency(locale: 'en_KE', symbol: 'KES ').format(premium)}'),
            const SizedBox(height: 8),
            Text('Client: ${client.fullName}'),
            Text('Vehicle: ${vehicle.fullName}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // TODO: Implement actual selection logic
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Selected ${insurer.name} for ${client.fullName}'),
                ),
              );
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }
}

