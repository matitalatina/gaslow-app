deploy-android:
	flutter build appbundle --target-platform android-arm,android-arm64;
	cd android && bundle install && bundle exec fastlane android deploy;

bundle-ios:
	flutter build ipa
