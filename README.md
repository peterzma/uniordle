# Flutter Wordle

## Overview

Flutter Wordle is a Wordle-style word puzzle game built with Flutter and Dart. You guess a hidden word within a limited number of attempts, using colour feedback to guide each guess.

## Features

* Wordle-style word guessing gameplay
* On-screen keyboard with colour feedback
* Limited guesses per round
* Valid word checking
* Clean, minimal UI

## Getting Started

### Prerequisites

* Flutter SDK
* Dart SDK
* For web testing:

  * Python 3 installed
* For Windows builds:

  * Windows 10 or 11
  * Visual Studio with C++ desktop workload

### Installation

Clone the repository:

```bash
git clone https://github.com/peterzma/flutter-wordle.git
```

Install dependencies:

```bash
flutter pub get
```

### Running the Game

#### Run in development

Web:

```bash
flutter run -d chrome
```

Windows:

```bash
flutter run -d windows
```

#### Build the game

Web:

```bash
flutter build web
```

Windows:

```bash
flutter build windows
```

## Releases

You can download prebuilt versions from GitHub Releases:

* Windows build: download and run the `.exe`

Latest release:
**[v1.0.0](https://github.com/peterzma/flutter-wordle/releases/tag/v1.0.0)**

## How to Play

* **Type letters:** Click the on-screen keys
* **Submit guess:** Enter
* **Delete letter:** Backspace
* **Green tile:** Correct letter and position
* **Yellow tile:** Correct letter, wrong position
* **Grey tile:** Letter not in the word
* **Win:** Guess the word within the allowed attempts

## TODO

* Add a larger word list for random selection
* Improve UI for game over, restart, and win states
* Add full physical keyboard input support
* Add custom game modes
