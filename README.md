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
* Change transition between screens
* Motion blur on game back to game settings transition
* Add more words
* Add sound/music
* Add stats/profile screens
* change sound effect of tile flipping in game screen
* replace ui click on buttons to be more minimal
* Add level system - make levels longer to complete every discpline unlock
* Add locked disciplines - let player choose 1 from the start, unlock every 5 levels.
* Add level up pop up.
* Add win/loss sound to end dialog