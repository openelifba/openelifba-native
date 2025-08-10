import 'package:openelifba/constants/assets.dart';
import 'package:openelifba/presentation/auth/store/user_store.dart';
import 'package:openelifba/utils/routes/routes.dart';
import 'package:openelifba/utils/logger/app_logger.dart';
import 'package:flutter/material.dart';

import '../../di/service_locator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //stores:---------------------------------------------------------------------
  final UserStore _userStore = getIt<UserStore>();
  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();
    // Start auto-login process
    _performAutoLogin();
  }

  Future<void> _performAutoLogin() async {
    try {
      // Show splash screen for 3 seconds
      await Future.delayed(const Duration(seconds: 2));

      // Perform auto-login with device ID
      await _userStore.autoLoginWithDeviceId();

      // Navigate after successful login
      _navigateToHome();
    } catch (e) {
      AppLogger.error('Auto-login failed', 'SplashScreen', e);
      // On failure, still navigate to home - the app should handle unauthenticated states
      _navigateToHome();
    }
  }

  void _navigateToHome() {
    if (mounted && !_hasNavigated) {
      _hasNavigated = true;
      Navigator.of(context).pushReplacementNamed(Routes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Full screen background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.loginBackground),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Semi-transparent overlay for better text visibility
          Container(
            color: Colors.black.withValues(alpha: 0.4),
          ),

          // Content overlay with app logo and loading indicator
          const SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Empty content - just showing the background image
              ],
            ),
          ),
        ],
      ),
    );
  }
}
