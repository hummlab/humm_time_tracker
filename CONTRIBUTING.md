# Contributing

Thanks for your interest in contributing to Time Tracker!

## Quick Start

1. Fork the repo and create a feature branch.
2. Install dependencies:
   - `flutter pub get`
   - `npm --prefix functions install`
3. Run static analysis:
   - `fvm flutter analyze`
4. Make sure generated files are up to date when editing models:
   - `dart run build_runner build --delete-conflicting-outputs`
5. Format code:
   - `dart format --line-length 120 lib`

## Pull Requests

- Describe the change clearly.
- Add or update tests when applicable.
- Make sure `flutter analyze` passes.

## Reporting Issues

If you find a bug or security issue, open a GitHub issue with steps to reproduce.

## Code of Conduct

By participating, you agree to the Code of Conduct in `CODE_OF_CONDUCT.md`.
