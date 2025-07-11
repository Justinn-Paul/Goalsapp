import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';

class TabSelector extends StatelessWidget {
  const TabSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        final selectedCategory = state is HomeLoaded
            ? state.selectedCategory
            : null;

        return Container(
          height: 50,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildTab(context, 'All', null, selectedCategory),
              _buildTab(context, 'Faith', 'Faith', selectedCategory),
              _buildTab(context, 'Music', 'Music', selectedCategory),
              _buildTab(context, 'Fitness', 'Fitness', selectedCategory),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTab(
    BuildContext context,
    String label,
    String? category,
    String? selectedCategory,
  ) {
    final isSelected =
        category == selectedCategory ||
        (category == null && selectedCategory == null);

    // Define colors for each category
    Color getBackgroundColor() {
      if (isSelected) {
        // Selected state - brighter colors
        switch (category) {
          case 'Faith':
            return Colors.blue[300]!; // Brighter blue
          case 'Music':
            return Colors.orange[300]!; // Brighter orange
          case 'Fitness':
            return Colors.green[300]!; // Brighter green
          default: // 'All'
            return Colors.grey[400]!; // Brighter grey
        }
      } else {
        // Not selected - dimmed colors
        switch (category) {
          case 'Faith':
            return Colors.blue[50]!; // Dim blue
          case 'Music':
            return Colors.orange[50]!; // Dim orange
          case 'Fitness':
            return Colors.green[50]!; // Dim green
          default: // 'All'
            return Colors.grey[100]!; // Dim grey
        }
      }
    }

    Color getTextColor() {
      if (isSelected) {
        return Colors.white; // White text for selected
      } else {
        // Dimmed text colors for unselected
        switch (category) {
          case 'Faith':
            return Colors.blue[400]!; // Dim blue text
          case 'Music':
            return Colors.orange[400]!; // Dim orange text
          case 'Fitness':
            return Colors.green[400]!; // Dim green text
          default: // 'All'
            return Colors.grey[600]!; // Dim grey text
        }
      }
    }

    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(
          label,
          style: TextStyle(
            color: getTextColor(),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        selected: isSelected,
        onSelected: (selected) {
          if (selected) {
            if (category == null) {
              context.read<HomeBloc>().add(const ClearFilters());
            } else {
              context.read<HomeBloc>().add(
                FilterGoalsByCategory(category: category),
              );
            }
          }
        },
        backgroundColor: getBackgroundColor(),
        selectedColor: getBackgroundColor(),
        checkmarkColor: Colors.white,
        elevation: isSelected ? 4 : 1,
        pressElevation: 6,
      ),
    );
  }
}
