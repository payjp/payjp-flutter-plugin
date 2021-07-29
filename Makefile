.PHONY: dependencies
dependencies:
	flutter pub get

.PHONY: check
check:
	flutter format --set-exit-if-changed --dry-run lib/ example/lib
	flutter analyze
	flutter test

.PHONY: build-ios-example
build-ios-example:
	cd example && flutter -v build ios --release --no-codesign

.PHONY: build-android-example
build-android-example:
	cd example && flutter -v build apk --release

.PHONY: driver-test
driver-test:
	cd example && flutter drive --driver=test_driver/integration_test.dart --target=integration_test/payjp_test.dart