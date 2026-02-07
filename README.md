# Uniordle

## Overview

Uniordle is a Wordle-style word puzzle game built with Flutter and Dart. Choose a category of words from the home menu and pick your settings.

## Features

* WIP
Merits
Credits
Levelling up
5 levels = credit
10 levels = rank up
abandon penalty increases by 10 from original 10 up until level 70. so -70
loss penalty increases by 5 from original 5 so -35
merits reduced by 50% on mastered majors
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
**[v1.0.0](https://github.com/chuckabox/uniordle/releases/tag/v1.0.0)**

## How to Play

* **Type letters:** Click the on-screen keys
* **Submit guess:** Enter
* **Delete letter:** Backspace
* **Green tile:** Correct letter and position
* **Yellow tile:** Correct letter, wrong position
* **Grey tile:** Letter not in the word
* **Win:** Guess the word within the allowed attempts

## TODO

* add intro for app only
* check/add sounds for everything needed.
* add more words
* add account syncing / creation with suprabase
* test with emulators
* check volumes are equalised
* finetune sounds by cutting off silence
* add indiciator of guest mode and give pop up for user to sign in to see stats
* stat for which majors played often? what grades are received most often?
* make variables consistent for future readability