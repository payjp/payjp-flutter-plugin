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
	cd example && flutter drive test_driver/payjp_e2e.dart