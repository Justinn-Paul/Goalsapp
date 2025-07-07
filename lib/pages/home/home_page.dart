import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../auth/bloc/auth_bloc.dart';
import '../auth/bloc/auth_event.dart';
import 'bloc/home_bloc.dart';
import 'bloc/home_event.dart';
import 'bloc/home_state.dart';
import 'widgets/tab_selector.dart';
import 'widgets/verse_display.dart';
import 'widgets/goal_card.dart';
import '../add_goal/add_goal_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(LoadGoals()),
      child: const HomePageView(),
    );
  }
}

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Goals'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(const AuthLogoutRequested());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Verse Display
          const VerseDisplay(),

          // Tab Selector
          const TabSelector(),

          // Goals List
          Expanded(
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is HomeLoaded) {
                  if (state.goals.isEmpty) {
                    return const Center(
                      child: Text(
                        'No goals yet. Add your first goal!',
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.goals.length,
                    itemBuilder: (context, index) {
                      final goal = state.goals[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: GoalCard(
                          goal: goal,
                          onTap: () {
                            // TODO: Navigate to edit goal page
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => EditGoalPage(goal: goal),
                            //   ),
                            // );
                          },
                        ),
                      );
                    },
                  );
                } else if (state is HomeError) {
                  return Center(child: Text('Error: ${state.message}'));
                }

                return const Center(child: Text('Something went wrong'));
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddGoalPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
