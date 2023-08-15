```
SOHEL PATHAN, sohelpathan6411@gmail.com
```APK```
https://drive.google.com/file/d/12xr50BKzTRscsVwOOYHes9GMlgMTGHdB/view?usp=sharing


------------------------------------------------------------
**Tech Stack:**
Flutter 3.10.5 • channel stable • https://github.com/flutter/flutter.git
Tools • Dart 3.0.5 • DevTools 2.23.1
------------------------------------------------------------

**Git Repository:**
https://github.com/sohelpathan6411/rti_sohel

------------------------------------------------------------

**Requirements:**

Android Studio
VS Code
Emulator/Simulator

------------------------------------------------------------

**Commands to run the app:**

flutter clean
flutter pub get
flutter run   

------------------------------------------------------------

**libs Used:**
  cupertino_icons: ^1.0.2
  flutter_bloc: ^7.0.0  //state management
  shared_preferences: ^2.2.0  //json data store
  intl: ^0.17.0  // dates utils
  google_fonts: ^5.1.0
  flutter_calendar_carousel: ^2.0.0  //calendar for custom date picker
  
**libs Modified:**
  flutter_calendar_carousel: ^2.0.0
  
  (Modification Details:
  calendar_header.dart -  modified due to padding & Alignment 
  the issue in the "month header" and arrow icons in the calendar.)
 
  **Changes: **
  1: build function:
  mainAxisAlignment: MainAxisAlignment.center,
  2: _rightButton & _leftButton
  padding: EdgeInsets.zero,
  
------------------------------------------------------------  
  
``` bash
│   main.dart
│
├───data
│   ├───models
│   │       employee.dart
│   │
│   ├───repositories
│   │       employee_repository.dart
│   │       employee_repository_implementation.dart
│   │
│   └───utils
│           date_utils.dart
│           size_config.dart
│
└───presentation
    ├───blocs
    │       employee_bloc.dart
    │       employee_event.dart
    │       employee_state.dart
    │
    ├───screens
    │       add_edit_screen.dart
    │       listing_screen.dart
    │
    ├───theme
    │       app_colors.dart
    │
    └───widgets
            calendar_img.dart
            custom_date_picker.dart
            employee_list_item.dart
            no_records_found.dart
            section_title.dart
```
------------------------------------------------------------

"# rti_sohel" 
