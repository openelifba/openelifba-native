import 'package:flutter/material.dart';

/// Theme extension to hold feature specific colors that should not be hard-coded
/// inside presentation layer widgets.
@immutable
class CategoryColors extends ThemeExtension<CategoryColors> {
  final Color activeGradientStart;
  final Color activeGradientEnd;
  final Color inactiveGradientStart;
  final Color inactiveGradientEnd;
  final Color activeShadow;
  final Color inactiveShadow;
  final Color dueBadgeBg;
  final Color dueBadgeFg;
  final Color completedBadgeBg;
  final Color completedBadgeFg;
  final Color statCardBg;
  final Color actionButtonIcon;
  final Color actionButtonText;
  final Color accuracyHigh;
  final Color accuracyMedium;
  final Color accuracyLow;
  final Color statusNotStarted;
  final Color statusInProgress;
  final Color statusCompleted;

  const CategoryColors({
    required this.activeGradientStart,
    required this.activeGradientEnd,
    required this.inactiveGradientStart,
    required this.inactiveGradientEnd,
    required this.activeShadow,
    required this.inactiveShadow,
    required this.dueBadgeBg,
    required this.dueBadgeFg,
    required this.completedBadgeBg,
    required this.completedBadgeFg,
    required this.statCardBg,
    required this.actionButtonIcon,
    required this.actionButtonText,
    required this.accuracyHigh,
    required this.accuracyMedium,
    required this.accuracyLow,
    required this.statusNotStarted,
    required this.statusInProgress,
    required this.statusCompleted,
  });

  static CategoryColors light = CategoryColors(
    activeGradientStart: const Color(0xFFE6D5B8), // Desert Sand
    activeGradientEnd: const Color(0xFFE4B343), // Saffron Gold
    inactiveGradientStart: const Color(0xFFFAF9F5), // Ivory White
    inactiveGradientEnd: const Color(0xFFE6D5B8), // Desert Sand
    activeShadow: const Color(0xFFE4B343).withValues(alpha: 0.3),
    inactiveShadow: Colors.black.withValues(alpha: 0.05),
    dueBadgeBg: const Color(0xFFE4B343).withValues(alpha: 0.2),
    dueBadgeFg: const Color(0xFF1E7D55), // Emerald Green
    completedBadgeBg: const Color(0xFFA3D9A5).withValues(alpha: 0.2), // Mint Green
    completedBadgeFg: const Color(0xFF1E7D55), // Emerald Green
    statCardBg: const Color(0xFFFAF9F5).withValues(alpha: 0.6), // Ivory White
    actionButtonIcon: const Color(0xFF1E7D55), // Emerald Green
    actionButtonText: const Color(0xFF1E7D55), // Emerald Green
    accuracyHigh: const Color(0xFFA3D9A5), // Mint Green
    accuracyMedium: const Color(0xFFE4B343), // Saffron Gold
    accuracyLow: const Color(0xFFC0392B), // Pomegranate Red
    statusNotStarted: Colors.grey,
    statusInProgress: const Color(0xFFE4B343), // Saffron Gold
    statusCompleted: const Color(0xFFA3D9A5), // Mint Green
  );

  static CategoryColors dark = CategoryColors(
    activeGradientStart: const Color(0xFF333333), // Charcoal Gray
    activeGradientEnd: const Color(0xFFE4B343), // Saffron Gold
    inactiveGradientStart: const Color(0xFF121212),
    inactiveGradientEnd: const Color(0xFF333333), // Charcoal Gray
    activeShadow: const Color(0xFFE4B343).withValues(alpha: 0.4),
    inactiveShadow: Colors.black.withValues(alpha: 0.4),
    dueBadgeBg: const Color(0xFFE4B343).withValues(alpha: 0.25),
    dueBadgeFg: const Color(0xFFE6D5B8), // Desert Sand
    completedBadgeBg: const Color(0xFFA3D9A5).withValues(alpha: 0.3), // Mint Green
    completedBadgeFg: const Color(0xFFFAF9F5), // Ivory White
    statCardBg: Colors.white.withValues(alpha: 0.08),
    actionButtonIcon: const Color(0xFFE6D5B8), // Desert Sand
    actionButtonText: const Color(0xFFE6D5B8), // Desert Sand
    accuracyHigh: const Color(0xFFA3D9A5), // Mint Green
    accuracyMedium: const Color(0xFFE4B343), // Saffron Gold
    accuracyLow: const Color(0xFFE57373), // Lighter Pomegranate Red
    statusNotStarted: Colors.grey,
    statusInProgress: const Color(0xFFE4B343), // Saffron Gold
    statusCompleted: const Color(0xFFA3D9A5), // Mint Green
  );

  @override
  ThemeExtension<CategoryColors> copyWith({
    Color? activeGradientStart,
    Color? activeGradientEnd,
    Color? inactiveGradientStart,
    Color? inactiveGradientEnd,
    Color? activeShadow,
    Color? inactiveShadow,
    Color? dueBadgeBg,
    Color? dueBadgeFg,
    Color? completedBadgeBg,
    Color? completedBadgeFg,
    Color? statCardBg,
    Color? actionButtonIcon,
    Color? actionButtonText,
    Color? accuracyHigh,
    Color? accuracyMedium,
    Color? accuracyLow,
    Color? statusNotStarted,
    Color? statusInProgress,
    Color? statusCompleted,
  }) {
    return CategoryColors(
      activeGradientStart: activeGradientStart ?? this.activeGradientStart,
      activeGradientEnd: activeGradientEnd ?? this.activeGradientEnd,
      inactiveGradientStart:
          inactiveGradientStart ?? this.inactiveGradientStart,
      inactiveGradientEnd: inactiveGradientEnd ?? this.inactiveGradientEnd,
      activeShadow: activeShadow ?? this.activeShadow,
      inactiveShadow: inactiveShadow ?? this.inactiveShadow,
      dueBadgeBg: dueBadgeBg ?? this.dueBadgeBg,
      dueBadgeFg: dueBadgeFg ?? this.dueBadgeFg,
      completedBadgeBg: completedBadgeBg ?? this.completedBadgeBg,
      completedBadgeFg: completedBadgeFg ?? this.completedBadgeFg,
      statCardBg: statCardBg ?? this.statCardBg,
      actionButtonIcon: actionButtonIcon ?? this.actionButtonIcon,
      actionButtonText: actionButtonText ?? this.actionButtonText,
      accuracyHigh: accuracyHigh ?? this.accuracyHigh,
      accuracyMedium: accuracyMedium ?? this.accuracyMedium,
      accuracyLow: accuracyLow ?? this.accuracyLow,
      statusNotStarted: statusNotStarted ?? this.statusNotStarted,
      statusInProgress: statusInProgress ?? this.statusInProgress,
      statusCompleted: statusCompleted ?? this.statusCompleted,
    );
  }

  @override
  ThemeExtension<CategoryColors> lerp(
      ThemeExtension<CategoryColors>? other, double t) {
    if (other is! CategoryColors) return this;
    return CategoryColors(
      activeGradientStart:
          Color.lerp(activeGradientStart, other.activeGradientStart, t)!,
      activeGradientEnd:
          Color.lerp(activeGradientEnd, other.activeGradientEnd, t)!,
      inactiveGradientStart:
          Color.lerp(inactiveGradientStart, other.inactiveGradientStart, t)!,
      inactiveGradientEnd:
          Color.lerp(inactiveGradientEnd, other.inactiveGradientEnd, t)!,
      activeShadow: Color.lerp(activeShadow, other.activeShadow, t)!,
      inactiveShadow: Color.lerp(inactiveShadow, other.inactiveShadow, t)!,
      dueBadgeBg: Color.lerp(dueBadgeBg, other.dueBadgeBg, t)!,
      dueBadgeFg: Color.lerp(dueBadgeFg, other.dueBadgeFg, t)!,
      completedBadgeBg:
          Color.lerp(completedBadgeBg, other.completedBadgeBg, t)!,
      completedBadgeFg:
          Color.lerp(completedBadgeFg, other.completedBadgeFg, t)!,
      statCardBg: Color.lerp(statCardBg, other.statCardBg, t)!,
      actionButtonIcon:
          Color.lerp(actionButtonIcon, other.actionButtonIcon, t)!,
      actionButtonText:
          Color.lerp(actionButtonText, other.actionButtonText, t)!,
      accuracyHigh: Color.lerp(accuracyHigh, other.accuracyHigh, t)!,
      accuracyMedium: Color.lerp(accuracyMedium, other.accuracyMedium, t)!,
      accuracyLow: Color.lerp(accuracyLow, other.accuracyLow, t)!,
      statusNotStarted:
          Color.lerp(statusNotStarted, other.statusNotStarted, t)!,
      statusInProgress:
          Color.lerp(statusInProgress, other.statusInProgress, t)!,
      statusCompleted: Color.lerp(statusCompleted, other.statusCompleted, t)!,
    );
  }
}

@immutable
class ExerciseColors extends ThemeExtension<ExerciseColors> {
  final Color cardGradientStart;
  final Color cardGradientEnd;
  final Color characterTileBg;
  final Color characterTileText;
  final Color characterTileShadow;
  final Color audioButtonBg;
  final Color audioButtonShadow;
  final Color onAccent;
  final Color needPracticeButtonBg;
  final Color masteredButtonBg;
  final Color homeButtonBg;
  final Color practiceAgainButtonBg;
  final Color completionIcon;
  final Color completionHeadline;
  final Color completionBodyText;
  final Color feedbackSuccess;
  final Color feedbackWarning;

  const ExerciseColors({
    required this.cardGradientStart,
    required this.cardGradientEnd,
    required this.characterTileBg,
    required this.characterTileText,
    required this.characterTileShadow,
    required this.audioButtonBg,
    required this.audioButtonShadow,
    required this.onAccent,
    required this.needPracticeButtonBg,
    required this.masteredButtonBg,
    required this.homeButtonBg,
    required this.practiceAgainButtonBg,
    required this.completionIcon,
    required this.completionHeadline,
    required this.completionBodyText,
    required this.feedbackSuccess,
    required this.feedbackWarning,
  });

  static ExerciseColors light = ExerciseColors(
    cardGradientStart: const Color(0xFFFAF9F5), // Ivory White
    cardGradientEnd: const Color(0xFFE6D5B8), // Desert Sand
    characterTileBg: const Color(0xFFFAF9F5), // Ivory White
    characterTileText: const Color(0xFF333333), // Charcoal Gray
    characterTileShadow: Colors.black.withValues(alpha: 0.05),
    audioButtonBg: const Color(0xFF1E7D55), // Emerald Green
    audioButtonShadow: const Color(0xFF1E7D55).withValues(alpha: 0.3),
    onAccent: const Color(0xFFFAF9F5), // Ivory White
    needPracticeButtonBg: const Color(0xFFE4B343), // Saffron Gold
    masteredButtonBg: const Color(0xFFA3D9A5), // Mint Green
    homeButtonBg: const Color(0xFF2D8C8C), // Deep Turquoise
    practiceAgainButtonBg: const Color(0xFF1E7D55), // Emerald Green
    completionIcon: const Color(0xFFA3D9A5), // Mint Green
    completionHeadline: const Color(0xFF1E7D55), // Emerald Green
    completionBodyText: const Color(0xFF333333), // Charcoal Gray
    feedbackSuccess: const Color(0xFFA3D9A5), // Mint Green
    feedbackWarning: const Color(0xFFE4B343), // Saffron Gold
  );

  static ExerciseColors dark = ExerciseColors(
    cardGradientStart: const Color(0xFF333333), // Charcoal Gray
    cardGradientEnd: const Color(0xFF121212),
    characterTileBg: const Color(0xFF333333), // Charcoal Gray
    characterTileText: const Color(0xFFFAF9F5), // Ivory White
    characterTileShadow: Colors.black.withValues(alpha: 0.6),
    audioButtonBg: const Color(0xFF26a269), // Lighter Emerald Green
    audioButtonShadow: const Color(0xFF26a269).withValues(alpha: 0.35),
    onAccent: const Color(0xFF121212),
    needPracticeButtonBg: const Color(0xFFE4B343), // Saffron Gold
    masteredButtonBg: const Color(0xFFA3D9A5), // Mint Green
    homeButtonBg: const Color(0xFF4DB6AC), // Lighter Deep Turquoise
    practiceAgainButtonBg: const Color(0xFF26a269), // Lighter Emerald Green
    completionIcon: const Color(0xFFA3D9A5), // Mint Green
    completionHeadline: const Color(0xFFE6D5B8), // Desert Sand
    completionBodyText: const Color(0xFFFAF9F5), // Ivory White
    feedbackSuccess: const Color(0xFFA3D9A5), // Mint Green
    feedbackWarning: const Color(0xFFE4B343), // Saffron Gold
  );

  @override
  ExerciseColors copyWith({
    Color? cardGradientStart,
    Color? cardGradientEnd,
    Color? characterTileBg,
    Color? characterTileText,
    Color? characterTileShadow,
    Color? audioButtonBg,
    Color? audioButtonShadow,
    Color? onAccent,
    Color? needPracticeButtonBg,
    Color? masteredButtonBg,
    Color? homeButtonBg,
    Color? practiceAgainButtonBg,
    Color? completionIcon,
    Color? completionHeadline,
    Color? completionBodyText,
    Color? feedbackSuccess,
    Color? feedbackWarning,
  }) {
    return ExerciseColors(
      cardGradientStart: cardGradientStart ?? this.cardGradientStart,
      cardGradientEnd: cardGradientEnd ?? this.cardGradientEnd,
      characterTileBg: characterTileBg ?? this.characterTileBg,
      characterTileText: characterTileText ?? this.characterTileText,
      characterTileShadow: characterTileShadow ?? this.characterTileShadow,
      audioButtonBg: audioButtonBg ?? this.audioButtonBg,
      audioButtonShadow: audioButtonShadow ?? this.audioButtonShadow,
      onAccent: onAccent ?? this.onAccent,
      needPracticeButtonBg: needPracticeButtonBg ?? this.needPracticeButtonBg,
      masteredButtonBg: masteredButtonBg ?? this.masteredButtonBg,
      homeButtonBg: homeButtonBg ?? this.homeButtonBg,
      practiceAgainButtonBg:
          practiceAgainButtonBg ?? this.practiceAgainButtonBg,
      completionIcon: completionIcon ?? this.completionIcon,
      completionHeadline: completionHeadline ?? this.completionHeadline,
      completionBodyText: completionBodyText ?? this.completionBodyText,
      feedbackSuccess: feedbackSuccess ?? this.feedbackSuccess,
      feedbackWarning: feedbackWarning ?? this.feedbackWarning,
    );
  }

  @override
  ThemeExtension<ExerciseColors> lerp(
      ThemeExtension<ExerciseColors>? other, double t) {
    if (other is! ExerciseColors) return this;
    return ExerciseColors(
      cardGradientStart:
          Color.lerp(cardGradientStart, other.cardGradientStart, t)!,
      cardGradientEnd: Color.lerp(cardGradientEnd, other.cardGradientEnd, t)!,
      characterTileBg: Color.lerp(characterTileBg, other.characterTileBg, t)!,
      characterTileText:
          Color.lerp(characterTileText, other.characterTileText, t)!,
      characterTileShadow:
          Color.lerp(characterTileShadow, other.characterTileShadow, t)!,
      audioButtonBg: Color.lerp(audioButtonBg, other.audioButtonBg, t)!,
      audioButtonShadow:
          Color.lerp(audioButtonShadow, other.audioButtonShadow, t)!,
      onAccent: Color.lerp(onAccent, other.onAccent, t)!,
      needPracticeButtonBg:
          Color.lerp(needPracticeButtonBg, other.needPracticeButtonBg, t)!,
      masteredButtonBg:
          Color.lerp(masteredButtonBg, other.masteredButtonBg, t)!,
      homeButtonBg: Color.lerp(homeButtonBg, other.homeButtonBg, t)!,
      practiceAgainButtonBg:
          Color.lerp(practiceAgainButtonBg, other.practiceAgainButtonBg, t)!,
      completionIcon: Color.lerp(completionIcon, other.completionIcon, t)!,
      completionHeadline:
          Color.lerp(completionHeadline, other.completionHeadline, t)!,
      completionBodyText:
          Color.lerp(completionBodyText, other.completionBodyText, t)!,
      feedbackSuccess: Color.lerp(feedbackSuccess, other.feedbackSuccess, t)!,
      feedbackWarning: Color.lerp(feedbackWarning, other.feedbackWarning, t)!,
    );
  }
}
