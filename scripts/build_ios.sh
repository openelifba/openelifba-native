#!/bin/bash

# Exit on error
set -e

echo "🚀 Starting Flutter iOS Build Process..."

# 1. Clean and get dependencies
echo "🧹 Cleaning project..."
flutter clean

echo "📦 Getting dependencies..."
flutter pub get

# 2. iOS Specific setup
cd ios
echo "🍎 Installing CocoaPods..."
pod install
cd ..

# 3. Build IPA
echo "🏗️ Building IPA for App Store..."
# Note: This requires a valid distribution certificate and provisioning profile matched in ExportOptions.plist
flutter build ipa --release --export-options-plist=ios/ExportOptions.plist

echo "✅ Build complete! You can find the IPA in build/ios/ipa/"
echo "📂 Opening build folder..."
open build/ios/ipa/
