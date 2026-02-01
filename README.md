# Uniordle

## Overview

Uniordle is a Wordle-style word puzzle game built with Flutter and Dart. Choose a category of words from the home menu and pick your settings.

## Features

* WIP

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
git clone https://github.com/peterzma/uniordle.git
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
**[v1.0.0](https://github.com/peterzma/uniordle/releases/tag/v1.0.0)**

## How to Play

* **Type letters:** Click the on-screen keys
* **Submit guess:** Enter
* **Delete letter:** Backspace
* **Green tile:** Correct letter and position
* **Yellow tile:** Correct letter, wrong position
* **Grey tile:** Letter not in the word
* **Win:** Guess the word within the allowed attempts

## TODO

* Make categories more university related
* Add more words
* Add sound/music
* Add stats/profile screens
* change sound effect of tile flipping in game screen
* replace ui click on buttons to be more minimal
* Add win/loss sound to end dialog
* add intro for app only
* add progress on each major. increase likihood of new unique words. once mastered, **stop user from farming it by decreasing merits earned** (need to add this part now)
* **IMPROVE APPEARANCE AND DESIGN AFTER ADDING LOGIC**
* **IMPORTANT: ensure widths 360 to 512 are handled properly**
* check/add sounds for everything needed. add music, add music toggle
* add more words
* replace vague categories with more specific
* update help dialog to account for: abandoining game loses merits. losing game loses merits, lose more as you rank up.
* add account syncing / creation with suprabase
* test with emulators
* check volumes are equalised
* if adding music - add mute button top right next to help button in game