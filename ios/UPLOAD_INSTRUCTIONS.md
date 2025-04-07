# App Store Upload Instructions

## Preparation

1. Ensure you've updated the version number in both:
   - pubspec.yaml (currently 3.0.29+1)
   - ios/Runner/Info.plist (currently 3.0.29)

2. Make sure you're signed in to Xcode with the correct Apple Developer account:
   - Xcode → Preferences → Accounts
   - Select your Apple ID
   - View Details
   - Ensure the Hotline Public Distribution certificate is present

## Build Process

1. Clean build artifacts:
```bash
flutter clean
flutter pub get
```

2. Build the iOS app:
```bash
cd /Users/jeffreyscruggs/StudioProjects/hotlines_mobile_MS
flutter build ios --release
```

3. Open the project in Xcode:
```bash
open ios/Runner.xcworkspace
```

4. In Xcode:
   - Select the "Runner" project in the navigator
   - Select the "Runner" target
   - Go to the "Signing & Capabilities" tab
   - Ensure "Hotline Public Distribution" team is selected for Release configuration
   - Select "Any iOS Device" at the top of Xcode (not a simulator)

5. Create Archive:
   - In Xcode menu, go to Product → Archive
   - Wait for archiving to complete

6. Process Archive:
   - After archiving finishes, Xcode Organizer will open automatically
   - Select your new archive
   - Click "Distribute App"
   - Choose "App Store Connect"
   - Click "Next"
   - Choose "Upload"
   - Click "Next" through the options (using default settings)
   - Click "Upload"

7. Remove Bitcode if validation fails:
   - If you see bitcode validation errors, run the remove_bitcode.sh script:
```bash
cd /Users/jeffreyscruggs/StudioProjects/hotlines_mobile_MS
./ios/remove_bitcode.sh
```
   - Then try the upload again

## Finalize on App Store Connect

1. Go to [App Store Connect](https://appstoreconnect.apple.com)
2. Navigate to "My Apps" and select your app
3. Create a new version:
   - Click the "+" button next to "iOS App"
   - Enter version number 3.0.29
   - Fill in "What's New" text describing the MLB feature addition
4. Select the build when it appears (might take a few minutes after upload)
5. Submit for Review

## Troubleshooting

- **Certificate issues**: Generate new certificates in Apple Developer Portal
- **Provisioning profile issues**: Let Xcode manage provisioning profiles automatically
- **Build errors**: Check Xcode logs for detailed error messages
- **Upload failures**: Make sure you have a stable internet connection

For further assistance, contact Apple Developer Support or refer to the [App Store Connect Help](https://help.apple.com/app-store-connect/).