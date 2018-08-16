#!/bin/sh

set -e

if [[ "$TRAVIS_OS_NAME" == "linux" ]]; then
    flutter build apk --release;
    cd android;
    fastlane android deploy;
    cd -;
fi