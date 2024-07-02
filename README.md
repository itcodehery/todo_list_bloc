# Todo List App

![Platform](https://img.shields.io/badge/platform-Flutter-blue)
![Contributors](https://img.shields.io/github/contributors/itcodehery/todo_list_bloc)
![Stars](https://img.shields.io/github/stars/itcodehery/todo_list_bloc)

## Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Screenshots](#screenshots)
- [Installation](#installation)
- [Usage](#usage)
- [State Management](#state-management)
- [Data Storage](#data-storage)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

## Overview

This **Todo List App** is a simple application built with **Flutter**. It uses **Bloc** for state management, **Shared Preferences** for persistent settings, and **Sqflite** for storing and managing tasks. The app helps users keep track of their tasks, set reminders, and organize their daily activities effectively.

## Features

- **Add, Update, and Delete Todos**: Easily manage your tasks.
- **Mark as Completed**: Check off completed tasks.
- **Persistent Storage**: Store tasks locally using **Sqflite**.
- **State Management**: Efficient state handling with **Bloc**.
- **Dark Mode**: Toggle between light and dark themes.
- **Settings**: Save user preferences with **Shared Preferences**.

## Screenshots

<p align="center">
  <img src="../../screenshots/home_dark.png" alt="Home Screen" width="200"/>
  <img src="../../screenshots/home_light.png" alt="Settings Screen" width="200"/>
  <img src="../../screenshots/todo_info" alt="Settings Screen" width="200"/>
  <img src="../../screenshots/add_todo.png" alt="Add Todo Screen" width="200"/>
</p>

## Installation

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install)
- [Dart](https://dart.dev/get-dart)
- [Android Studio](https://developer.android.com/studio) or [VSCode](https://code.visualstudio.com/)

### Steps

1. **Clone the repository**:

    ```bash
    git clone https://github.com/username/todo_list_app.git
    cd todo_list_app
    ```

2. **Install dependencies**:

    ```bash
    flutter pub get
    ```

3. **Run the app**:

    ```bash
    flutter run
    ```

## Usage

### Adding a Todo

1. Tap the `Add Item` button on the home screen.
2. Enter the task details.
3. Save the task by tapping the `Add` button.

### Marking as Completed

- Tap the checkbox next to a task to mark it as completed.

### Toggling Dark Mode

1. Go to the `Settings` page.
2. Toggle the dark mode switch.

## State Management

The app uses the **Bloc** pattern for state management. **Bloc** (Business Logic Component) separates the presentation layer from the business logic, ensuring a clear separation of concerns.

## Data Storage

The app uses **Sqflite** for local data storage and **Shared Preferences** for storing user settings.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any bug fixes or new features.

### Steps

1. **Fork the repository**.
2. **Create a branch** for your feature or fix:

    ```bash
    git checkout -b feature-name
    ```

3. **Commit your changes**:

    ```bash
    git commit -m 'Add some feature'
    ```

4. **Push to the branch**:

    ```bash
    git push origin feature-name
    ```

5. **Open a Pull Request**.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contact

- **GitHub**: [itcodehery](https://github.com/itcodehery)
- **Email**: [haririo321@gmail.com](mailto:haririo321@gmail.com)
