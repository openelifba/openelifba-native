import 'package:openelifba/presentation/exercise/store/exercise_store.dart';
import 'package:openelifba/utils/logger/app_logger.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'dart:async';

import '../../di/service_locator.dart';
import '../../domain/entity/exercise/exercise.dart';
import '../../core/widgets/progress_indicator_widget.dart';
import '../../utils/locale/app_localization.dart';
import 'package:openelifba/constants/theme_extensions.dart';

class ExerciseScreen extends StatefulWidget {
  final String categoryId;

  const ExerciseScreen({super.key, required this.categoryId});

  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  final ExerciseStore _exerciseStore = getIt<ExerciseStore>();
  final AudioPlayer _audioPlayer = AudioPlayer();
  final PageController _pageController = PageController();
  final Stopwatch _stopwatch = Stopwatch();

  @override
  void initState() {
    super.initState();
    _audioPlayer.setLoopMode(LoopMode.off);
    _exerciseStore.startTimer();
    _stopwatch.start();
    _exerciseStore.getDueExercises(widget.categoryId);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _stopwatch.stop();
    _exerciseStore.stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        
        // Stop any running timers before returning
        _stopwatch.stop();
        _exerciseStore.stopTimer();

        // Return true to indicate that categories should be refreshed
        Navigator.of(context).pop(true);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)
              .translate('exercise_practice_title')),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        _handleErrorMessage(),
        Observer(
          builder: (context) {
            if (_exerciseStore.loading) {
              return const CustomProgressIndicatorWidget();
            }

            if (_exerciseStore.dueExercises.isEmpty) {
              return Center(
                  child: Text(AppLocalizations.of(context)
                      .translate('no_exercises_available')));
            }

            if (_exerciseStore.allExercisesCompleted) {
              return _buildCompletionScreen();
            }

            return Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _exerciseStore.dueExercises.length,
                    onPageChanged: (index) {
                      _exerciseStore.setCurrentExerciseIndex(index);
                    },
                    itemBuilder: (context, index) {
                      final exercise = _exerciseStore.dueExercises[index];
                      return _buildExerciseCard(exercise);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40.0),
                  child: _buildActionBar(),
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildExerciseCard(Exercise exercise) {
    final exerciseColors = Theme.of(context).extension<ExerciseColors>()!;
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.all(24),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              exerciseColors.cardGradientStart,
              exerciseColors.cardGradientEnd
            ],
          ),
        ),
        child: InkWell(
          onTap: () => _playAudio(exercise),
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: exerciseColors.characterTileBg,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: exerciseColors.characterTileShadow,
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Text(
                    exercise.value,
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: exerciseColors.characterTileText,
                      fontFamily: 'Amiri',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  decoration: BoxDecoration(
                    color: exerciseColors.audioButtonBg,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: exerciseColors.audioButtonShadow,
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.volume_up,
                            color: exerciseColors.onAccent, size: 24),
                        const SizedBox(width: 8),
                        Text(
                          AppLocalizations.of(context)
                              .translate('btn_play_audio'),
                          style: TextStyle(
                            color: exerciseColors.onAccent,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
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

  Widget _buildActionBar() {
    final colors = Theme.of(context).extension<ExerciseColors>()!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                _handleNeedPractice(_exerciseStore.currentExerciseIndex);
              },
              icon: const Icon(Icons.refresh, color: Colors.white),
              label: Text(
                AppLocalizations.of(context).translate('btn_need_practice'),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.needPracticeButtonBg,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                _handleMastered(_exerciseStore.currentExerciseIndex);
              },
              icon: const Icon(Icons.check, color: Colors.white),
              label: Text(
                AppLocalizations.of(context).translate('btn_mastered'),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.masteredButtonBg,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletionScreen() {
    final colors = Theme.of(context).extension<ExerciseColors>()!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.celebration, size: 80, color: colors.completionIcon),
          const SizedBox(height: 24),
          Text(
            AppLocalizations.of(context).translate('all_exercises_completed'),
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: colors.completionHeadline,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)
                .translate('all_exercises_completed_body'),
            style: TextStyle(
              fontSize: 16,
              color: colors.completionBodyText,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _returnToHome();
                    },
                    icon: const Icon(Icons.home, color: Colors.white),
                    label: Text(
                      AppLocalizations.of(context).translate('btn_return_home'),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.homeButtonBg,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _resetExercises();
                    },
                    icon: const Icon(Icons.refresh, color: Colors.white),
                    label: Text(
                      AppLocalizations.of(context)
                          .translate('btn_practice_again'),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.practiceAgainButtonBg,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _handleMastered(int index) {
    _stopwatch.stop();
    _exerciseStore.stopTimer();
    _exerciseStore.updateElapsedTime(_stopwatch.elapsedMilliseconds);

    // Get the current exercise
    final currentExercise = _exerciseStore.dueExercises[index];

    // Update memory in the backend
    _exerciseStore.updateMemory(
      currentExercise.id,
      true, // success = true (mastered)
      _stopwatch.elapsedMilliseconds, // pass milliseconds directly
    );

    // Mark exercise as completed
    _exerciseStore.markExerciseCompleted(index);

    // Show feedback
    _showFeedbackMessage(
        AppLocalizations.of(context).translate('msg_exercise_mastered'),
        Theme.of(context).extension<ExerciseColors>()!.feedbackSuccess);

    _nextPage();
    _stopwatch.reset();
    _exerciseStore.startTimer();
    _stopwatch.start();
  }

  void _handleNeedPractice(int index) {
    _stopwatch.stop();
    _exerciseStore.stopTimer();
    _exerciseStore.updateElapsedTime(_stopwatch.elapsedMilliseconds);

    // Get the current exercise
    final currentExercise = _exerciseStore.dueExercises[index];

    // Update memory in the backend
    _exerciseStore.updateMemory(
      currentExercise.id,
      false, // success = false (needs practice)
      _stopwatch.elapsedMilliseconds, // pass milliseconds directly
    );

    // Show feedback
    _showFeedbackMessage(
        AppLocalizations.of(context).translate('msg_marked_for_more_practice'),
        Theme.of(context).extension<ExerciseColors>()!.feedbackWarning);

    _nextPage();
    _stopwatch.reset();
    _exerciseStore.startTimer();
    _stopwatch.start();
  }

  void _resetExercises() {
    _exerciseStore.resetExercises();
    _exerciseStore.getDueExercises(widget.categoryId);
    _pageController.animateToPage(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
    _stopwatch.reset();
    _exerciseStore.startTimer();
    _stopwatch.start();
  }

  void _returnToHome() {
    // Stop any running timers
    _stopwatch.stop();
    _exerciseStore.stopTimer();

    // Check if widget is still mounted before showing feedback or navigating
    if (!mounted) return;

    // Show completion feedback
    _showFeedbackMessage(
        AppLocalizations.of(context)
            .translate('msg_exercise_session_completed'),
        Theme.of(context).extension<ExerciseColors>()!.feedbackSuccess);

    // Return true to indicate that the exercises are completed and need refresh
    Navigator.of(context).pop(true);
  }

  void _nextPage() {
    if (_pageController.hasClients) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void _playAudio(Exercise exercise) async {
    try {
      await _audioPlayer.setUrl(exercise.audioUrl);
      await _audioPlayer.play();
    } catch (e) {
      AppLogger.error('Failed to play audio', 'ExerciseScreen', e);
      if (!mounted) return;
      _showFeedbackMessage(
          AppLocalizations.of(context).translate('error_could_not_play_audio'),
          Theme.of(context).extension<ExerciseColors>()!.feedbackWarning);
    }
  }

  void _showFeedbackMessage(String message, Color color) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(milliseconds: 500),
      ),
    );
  }

  Widget _handleErrorMessage() {
    return Observer(
      builder: (context) {
        if (_exerciseStore.errorStore.errorMessage.isNotEmpty) {
          return _showErrorMessage(_exerciseStore.errorStore.errorMessage);
        }
        return const SizedBox.shrink();
      },
    );
  }

  _showErrorMessage(String message) {
    Future.delayed(const Duration(milliseconds: 0), () {
      if (message.isNotEmpty) {
        if (!mounted) return;
        final flushbar = FlushbarHelper.createError(
          message: message,
          title: AppLocalizations.of(context).translate('home_tv_error'),
          duration: const Duration(seconds: 3),
        );
        flushbar.show(context);
      }
    });

    return const SizedBox.shrink();
  }
}
