#!/bin/sh

set -e

if [[ "$TRAVIS_OS_NAME" == "linux" ]]; then
    flutter build appbundle --target-platform android-arm,android-arm64;
    cd android;
    bundle install;
    bundle exec fastlane android deploy;
    cd -;
fi