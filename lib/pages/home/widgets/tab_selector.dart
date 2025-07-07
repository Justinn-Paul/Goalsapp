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

    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
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
        backgroundColor: Colors.grey[200],
        selectedColor: Colors.blue[100],
        checkmarkColor: Colors.blue,
      ),
    );
  }
}
