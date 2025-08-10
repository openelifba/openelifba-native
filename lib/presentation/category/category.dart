import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:openelifba/presentation/category/store/category_store.dart';
import 'package:openelifba/di/service_locator.dart';
import 'package:openelifba/domain/entity/category/category.dart';

import '../../utils/locale/app_localization.dart';
import '../exercise/exercise_screen.dart';
import 'package:openelifba/constants/theme_extensions.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final CategoryStore _categoryStore = getIt<CategoryStore>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  // ScrollController to manage scrolling to active cards
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _categoryStore.getCategories();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _navigateToExerciseScreen(Category category) async {
    final shouldRefresh = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => ExerciseScreen(categoryId: category.id),
      ),
    );

    // If returned with true, refresh the categories
    if (shouldRefresh == true) {
      _categoryStore.getCategories();
      // _showFeedbackMessage("Learning session completed!", Colors.green);
    }
  }

  // Method to find and scroll to the next active category
  void _scrollToNextActiveCard() {
    if (!_categoryStore.hasActiveCategories) {
      _showFeedbackMessage("No active categories to practice", Colors.blue);
      return;
    }

    // Find the current scroll position
    double currentPosition = _scrollController.offset;
    double itemHeight = 220; // Approximate height of each card including margin

    // Find the current visible item index
    int currentIndex = (currentPosition / itemHeight).floor();

    // Use store method to find next active index
    int nextActiveIndex = _categoryStore.findNextActiveIndex(currentIndex,
        itemHeight: itemHeight.toInt(), scrollPosition: currentPosition);

    // If found an active card, scroll to it
    if (nextActiveIndex != -1) {
      _scrollController.animateTo(
        nextActiveIndex * itemHeight,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      // Show message if no active cards found
      _showFeedbackMessage("No active categories to practice", Colors.blue);
    }
  }

  bool _isActiveCategory(Category category) {
    return _categoryStore.isActiveCategory(category);
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldKey,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Observer(
                builder: (context) {
                  if (_categoryStore.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (_categoryStore.categories.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.category_outlined,
                            size: 64,
                            color: Colors.grey.shade400,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            AppLocalizations.of(context)
                                .translate('no_categories_available'),
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: _categoryStore.categories.length,
                    itemBuilder: (context, index) {
                      final category = _categoryStore.categories[index];
                      return _buildCategoryCard(category);
                    },
                  );
                },
              ),
              // Add a floating action button to scroll to next active card
              Positioned(
                bottom: 16,
                right: 16,
                child: FloatingActionButton(
                  onPressed: _scrollToNextActiveCard,
                  backgroundColor: Colors.amber.shade600,
                  mini: true,
                  tooltip: AppLocalizations.of(context)
                      .translate('tooltip_next_active_category'),
                  child: const Icon(Icons.arrow_downward),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard(Category category) {
    final categoryColors = Theme.of(context).extension<CategoryColors>()!;
    // Calculate accuracy rate based on new statistic structure
    double accuracyRate = category.statistic.accuracyPercent;
    double averageSpeed = category.statistic.averageSpeedSec;
    bool hasStats = category.statistic.reviewedExerciseCount > 0;

    // Use new statistic properties to determine if category is active
    bool isActive = _isActiveCategory(category);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _navigateToExerciseScreen(category),
          borderRadius: BorderRadius.circular(16),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isActive
                    ? [
                        categoryColors.activeGradientStart,
                        categoryColors.activeGradientEnd
                      ]
                    : [
                        categoryColors.inactiveGradientStart,
                        categoryColors.inactiveGradientEnd
                      ],
              ),
              boxShadow: [
                BoxShadow(
                  color: isActive
                      ? categoryColors.activeShadow
                      : categoryColors.inactiveShadow,
                  blurRadius: isActive ? 15 : 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Main content padding
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, top: 28, right: 20, bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate(category.name),
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: category.statistic.dueExerciseCount > 0
                                  ? categoryColors.dueBadgeBg
                                  : categoryColors.completedBadgeBg,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  category.statistic.dueExerciseCount > 0
                                      ? Icons.access_time
                                      : Icons.check_circle,
                                  size: 16,
                                  color: category.statistic.dueExerciseCount > 0
                                      ? categoryColors.dueBadgeFg
                                      : categoryColors.completedBadgeFg,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${category.statistic.dueExerciseCount} ${AppLocalizations.of(context).translate('due')}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        category.statistic.dueExerciseCount > 0
                                            ? categoryColors.dueBadgeFg
                                            : categoryColors.completedBadgeFg,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (hasStats) ...[
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: _buildStatCard(
                                icon: Icons.speed,
                                label: AppLocalizations.of(context)
                                    .translate('stat_avg_speed'),
                                value:
                                    '${averageSpeed.toStringAsFixed(1)} ${AppLocalizations.of(context).translate('abbr_seconds')}',
                                color: isActive
                                    ? categoryColors.activeGradientEnd
                                    : Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildStatCard(
                                icon: Icons.check_circle_outline,
                                label: AppLocalizations.of(context)
                                    .translate('stat_accuracy'),
                                value: '${accuracyRate.toStringAsFixed(1)}%',
                                color: isActive
                                    ? categoryColors.activeGradientEnd
                                    : _getAccuracyColor(
                                        accuracyRate, categoryColors),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: _buildStatCard(
                                icon: Icons.book,
                                label: AppLocalizations.of(context)
                                    .translate('stat_total_exercises'),
                                value:
                                    '${category.statistic.totalExerciseCount}',
                                color: isActive
                                    ? categoryColors.activeGradientEnd
                                    : Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildStatCard(
                                icon: Icons.check,
                                label: AppLocalizations.of(context)
                                    .translate('stat_reviewed'),
                                value:
                                    '${category.statistic.reviewedExerciseCount}',
                                color: isActive
                                    ? categoryColors.activeGradientEnd
                                    : categoryColors.statusCompleted,
                              ),
                            ),
                          ],
                        ),
                      ],
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          _buildActionButton(
                            label: isActive
                                ? AppLocalizations.of(context)
                                    .translate('btn_practice_now')
                                : AppLocalizations.of(context)
                                    .translate('btn_start_learning'),
                            icon: isActive
                                ? Icons.priority_high
                                : Icons.play_arrow,
                            onTap: () => _navigateToExerciseScreen(category),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              color: _getStatusColor(
                                      category.statistic.status, categoryColors)
                                  .withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              AppLocalizations.of(context).translate(
                                  'status_${category.statistic.status}'),
                              style: TextStyle(
                                fontSize: 12,
                                color: _getStatusColor(
                                    category.statistic.status, categoryColors),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Conditional practice badge
                if (isActive)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(16),
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                      child: Text(
                        AppLocalizations.of(context)
                            .translate('badge_needs_practice'),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    final categoryColors = Theme.of(context).extension<CategoryColors>()!;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: categoryColors.statCardBg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, size: 16, color: color),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.6),
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getAccuracyColor(double accuracy, CategoryColors colors) {
    if (accuracy >= 80.0) return colors.accuracyHigh;
    if (accuracy >= 60.0) return colors.accuracyMedium;
    return colors.accuracyLow;
  }

  Color _getStatusColor(String status, CategoryColors colors) {
    switch (status) {
      case 'NOT_STARTED':
        return colors.statusNotStarted;
      case 'IN_PROGRESS':
        return colors.statusInProgress;
      case 'COMPLETED':
        return colors.statusCompleted;
      case 'ACTIVE':
        return colors.statusInProgress;
      default:
        return Theme.of(context).colorScheme.primary;
    }
  }

  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    final colors = Theme.of(context).extension<CategoryColors>()!;
    return Container(
      decoration: BoxDecoration(
        color: colors.statCardBg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 16, color: colors.actionButtonIcon),
                const SizedBox(width: 4),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 14,
                    color: colors.actionButtonText,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showFeedbackMessage(String message, Color color) {
    _scaffoldKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context).translate(message)),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(bottom: 100.0, left: 20.0, right: 20.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
