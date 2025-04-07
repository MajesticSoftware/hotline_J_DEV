#!/bin/bash

# This script removes bitcode from Facebook SDK frameworks

FRAMEWORKS_DIR="./build/ios/archive/Runner.xcarchive/Products/Applications/Runner.app/Frameworks"

# Check if directory exists
if [ ! -d "$FRAMEWORKS_DIR" ]; then
  echo "Error: Frameworks directory not found at $FRAMEWORKS_DIR"
  exit 1
fi

# List of Facebook frameworks to process
FB_FRAMEWORKS=(
  "FBAEMKit.framework/FBAEMKit"
  "FBSDKCoreKit.framework/FBSDKCoreKit"
  "FBSDKCoreKit_Basics.framework/FBSDKCoreKit_Basics"
  "FBSDKLoginKit.framework/FBSDKLoginKit"
)

# Process each framework
for FRAMEWORK in "${FB_FRAMEWORKS[@]}"; do
  FRAMEWORK_PATH="$FRAMEWORKS_DIR/$FRAMEWORK"
  
  if [ -f "$FRAMEWORK_PATH" ]; then
    echo "Removing bitcode from $FRAMEWORK"
    xcrun bitcode_strip -r "$FRAMEWORK_PATH" -o "$FRAMEWORK_PATH"
    echo "Bitcode removed from $FRAMEWORK"
  else
    echo "Framework not found: $FRAMEWORK_PATH"
  fi
done

echo "Bitcode removal completed"