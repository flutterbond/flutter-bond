# Flutter Bond

<p align="center"><a href="#" target="_blank"><img src="https://raw.githubusercontent.com/flutterbond/flutter-bond/5e75d3b52e12536478dc9b40455299f3f4e5c9cc/assets/images/app_logo.svg" width="400" alt="Flutter Bond Logo"></a></p>


[![Build](https://github.com/flutterbond/flutter-bond/actions/workflows/build.yml/badge.svg)](https://github.com/flutterbond/flutter-bond/actions/workflows/build.yml)
[![Free Palestine](https://img.shields.io/badge/Free_Palestine-%20%F0%9F%87%B5%F0%9F%87%B8-green)](https://github.com/flutterbond/flutter-bond)

Flutter Bond is a Palestinian product proudly developed in Gaza by a passionate Palestinian engineer. This template serves as One Studio’s public framework for all internal Flutter applications. We invite you to use this template for your projects and contribute to its ongoing improvement.

Flutter Bond is a work-in-progress mini-framework inspired by Clean Architecture, lessons learned from past projects, and innovative ideas from the Laravel ecosystem.


# About Flutter Bond

Flutter Bond is a mobile application framework built on top of Flutter with expressive, simplified architecture. Our aim is to make development not just easier but also fun. With Flutter Bond, you can focus more on building features rather than worrying about boilerplate code. Some of the core features are:

- Seamless state management.
- Simplified API calls with Bond Fire.
- Easy navigation and routing.
- Extensible architecture with Bond Core.
- CLI support for faster development with Bond CLI.

Flutter Bond is scalable, flexible, and designed to build robust, high-quality applications.

## Getting started

Requirements: Flutter 3.47.7 (Dart 3.13.5), Java 17,
Xcode 26 (iOS 15+), and `dart pub global activate flutterfire_cli` for iOS archives.

```sh
dart pub global activate bond_cli
bond create project            # clones this template at v2.0.0 and renames it
```

Or clone this repository and set it up by hand:

```sh
flutter pub get
cp env.example.json env.staging.json   # and env.json for production; timeouts are in milliseconds
flutter run --flavor Staging --dart-define-from-file=env.staging.json
flutter run --flavor Production --dart-define-from-file=env.json
```

- Flavors: `staging` / `production` on Android, `Staging` / `Production` schemes on iOS
  (bundle ids `ps.app.bond.staging` / `ps.app.bond`).
- Firebase: `lib/firebase_options_{production,staging}.dart`, `android/app/src/<flavor>/google-services.json`
  and `ios/<Flavor>/GoogleService-Info.plist`. The iOS Staging plist is a placeholder: replace it with
  the file from your Firebase console.
- iOS uses Swift Package Manager only (no CocoaPods). Set your `DEVELOPMENT_TEAM` in Xcode to run
  on a device.
- Android release builds are signed with `android/key.properties` if present, otherwise with the
  debug keys.

## Claude Code and MCP

`.mcp.json` registers two MCP servers. Claude Code asks once to approve them; check them with
`claude mcp list`.

- `dart`: the official Dart & Flutter MCP server: analyzer, pub, tests, reading and searching the
  source of every dependency (including the bond_* packages), and tools for the running app.
  It starts through `tool/mcp/dart.sh`, which always uses the Flutter version pinned in `.fvmrc`
  (3.47.7) and never another Flutter on your PATH.
- `bond`: the Bond MCP server from bond_cli: what each bond_* package does, its public API read from
  the version this project uses, migration notes, and the `bond create` generators (model, widget,
  service provider, project).
  Install it once with `dart install bond_cli` (Dart 3.13 or newer); `tool/mcp/bond.sh` starts it.

Projects created with `bond create project` inherit this setup.

## Versions

| Template | bond_* packages | bond_cli | Flutter |
|---|---|---|---|
| `v1.0.0` (legacy) | bond_core 0.0.3 … bond_form_riverpod 0.0.17+19 | 0.0.4+3 | 3.19 – 3.27 |
| `v2.0.0` | bond_core, cache, network, form, form_riverpod 0.1.x; notifications, app_analytics 0.2.x | 0.1.x | 3.47.7+ |

Upgrading a v1 app: see [MIGRATION.md](MIGRATION.md).

## Learning Flutter Bond

Flutter Bond comes with comprehensive documentation to get you up and running in no time. You can refer to our [Bond Docs Repo](https://github.com/flutterbond/bond-docs) for detailed guides and tutorials.

For hands-on experience, you can follow the Flutter Bond tutorial series to build a fully functional application from scratch.

If you prefer a more interactive learning experience, we're in the process of developing a complete video tutorial library.

## Flutter Bond Repositories
- [Bond Core](https://github.com/flutterbond/bond-core) - The core architecture.
- [Bond CLI](https://github.com/flutterbond/bond-cli) - The Command Line Interface for Flutter Bond.
- [Bond Docs](https://github.com/flutterbond/bond-docs) - Comprehensive Documentation.

## Sponsors

We are actively looking for sponsors to help us maintain and grow this project. If you are interested in becoming a sponsor, please get in touch with us.

## Contributing

We welcome contributions from the community. For guidelines on how to contribute, please refer to our [Contribution Guidelines](https://github.com/flutterbond/flutter-bond/blob/main/CONTRIBUTING.md).

## Security Vulnerabilities

If you discover a security vulnerability within Flutter Bond, please send an e-mail to [salahelamassi@gmail.com]. All security vulnerabilities will be promptly addressed.
