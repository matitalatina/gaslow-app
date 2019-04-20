#!/bin/sh

set -e

if [[ "$TRAVIS_OS_NAME" == "linux" ]]; then
    flutter build apk --release --no-track-widget-creation;
    cd android;
    bundle install;
    bundle exec fastlane android deploy;
    cd -;
fi