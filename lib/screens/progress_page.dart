import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import '../Provider/main_provider.dart';
import '../error_handler.dart';
import 'package:final_2/generated/l10n.dart';

class ProgressPage extends StatefulWidget {
  const ProgressPage({super.key});

  @override
  _ProgressPageState createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  bool showChallenges = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildStatCard(String label, String value, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.8), color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Consumer<MainProvider>(
      builder: (context, provider, child) {
        if (provider.errorMessage != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ErrorHandler.showError(context, provider.getTranslatedErrorMessage(context) ?? localizations.unknownError);
            provider.clearError();
          });
        }

        final items = showChallenges ? provider.allChallenges(context) : provider.allWorkouts(context);

        return Scaffold(
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: provider.loadProgress,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        localizations.yourProgress,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: _buildStatCard(
                              localizations.workouts,
                              provider.completed.toString(),
                              Colors.green,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _buildStatCard(
                              localizations.minutes,
                              provider.totalMinutes.toString(),
                              Colors.blue,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _buildStatCard(
                              localizations.challenges,
                              provider.completed.toString(),
                              Colors.red,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () => setState(() => showChallenges = true),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: showChallenges ? Colors.deepPurple : Colors.grey[300],
                              foregroundColor: showChallenges ? Colors.white : Colors.black,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: Text(localizations.challenges),
                          ),
                          ElevatedButton(
                            onPressed: () => setState(() => showChallenges = false),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: !showChallenges ? Colors.deepPurple : Colors.grey[300],
                              foregroundColor: !showChallenges ? Colors.white : Colors.black,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: Text(localizations.workouts),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        localizations.progressChart,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 200,
                        child: BarChart(
                          BarChartData(
                            alignment: BarChartAlignment.spaceAround,
                            maxY: 100,
                            barGroups: items
                                .asMap()
                                .entries
                                .map((entry) => BarChartGroupData(
                              x: entry.key,
                              barRods: [
                                BarChartRodData(
                                  toY: double.parse(entry.value['progress']!),
                                  color: Colors.deepPurple,
                                  width: 15,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ],
                            ))
                                .toList(),
                            titlesData: FlTitlesData(
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 40,
                                  getTitlesWidget: (value, meta) => Text(
                                    localizations.percentLabel(value.toInt()),
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              ),
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) => Text(
                                    items[value.toInt()]['title']!.substring(
                                        0,
                                        items[value.toInt()]['title']!.length > 5
                                            ? 5
                                            : items[value.toInt()]['title']!.length),
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              ),
                              topTitles: AxisTitles(),
                              rightTitles: AxisTitles(),
                            ),
                            borderData: FlBorderData(show: false),
                            gridData: FlGridData(show: false),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        showChallenges ? localizations.challenges : localizations.workouts,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...List.generate(
                        items.length,
                            (index) {
                          final item = items[index];
                          return AnimatedBuilder(
                            animation: _controller,
                            builder: (context, child) {
                              return Transform.translate(
                                offset: Offset(0, 50 * (1 - _fadeAnimation.value)),
                                child: Opacity(
                                  opacity: _fadeAnimation.value,
                                  child: child,
                                ),
                              );
                            },
                            child: Card(
                              elevation: 4,
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              child: ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    item['image']!,
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                title: Text(
                                  item['title']!,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 8),
                                    LinearProgressIndicator(
                                      value: double.parse(item['progress']!) / 100,
                                      backgroundColor: Colors.grey[300],
                                      color: Colors.deepPurple,
                                    ),
                                    const SizedBox(height: 4),
                                    Text('${item['progress']}${localizations.percentCompleted}'),
                                  ],
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.restart_alt, color: Colors.red),
                                  onPressed: () => showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                      title: Text(localizations.resetProgress),
                                      content: Text(localizations.resetProgressConfirm(item['title']!)),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: Text(
                                            localizations.cancel,
                                            style: const TextStyle(color: Colors.grey),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            provider.resetProgress(item['key']!, showChallenges); // Changed to use 'key'
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            localizations.reset,
                                            style: const TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
