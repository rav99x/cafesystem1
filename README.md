# Bean Counter Flutter App

A clean Flutter UI for a coffee shop sales and inventory management app.

## Important
This version intentionally uses **no database, no Supabase, no Firebase, no API, and no third-party chart package**.
It uses mock data only so the UI can be tested first.

## What is included
- Dashboard
- Sales overview
- New Sale POS-style screen
- Inventory
- Waste
- Purchases
- New Purchase
- Reports
- Employees
- Suppliers
- Settings
- Bottom navigation
- Named navigation routes

## Why this repository is designed to be stable
The app uses only Flutter SDK widgets. There are no custom packages for charts, no generated custom widgets, and no nullable `.split()` logic like the FlutterFlow custom Pie Chart that caused your analyzer error.

## Run locally
1. Install Flutter.
2. Clone this repository.
3. From the project folder run:

```bash
flutter create . --platforms=android,ios
flutter pub get
flutter analyze
flutter run
```

The `flutter create .` command creates the Android and iOS platform folders without replacing `lib/main.dart`.

## Push to GitHub
If you download this as a ZIP:
1. Create a new GitHub repository.
2. Upload all files/folders from this project.
3. Clone it on your computer.
4. Run the commands above.

## Next phase
After the UI is approved, connect Supabase for:
- Authentication
- Products
- Inventory items
- Recipes
- Sales
- Sale items
- Purchases
- Waste
- Employees
- Suppliers
- Realtime dashboard data
