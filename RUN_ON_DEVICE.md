# Run Driver App on Android Phone (USB Debugging)

## Prerequisites
- Flutter SDK installed and in PATH
- Android SDK installed (via Android Studio)
- USB cable

---

## Step 1: Enable Developer Options on Phone
1. Go to **Settings → About Phone**
2. Tap **Build Number** 7 times until it says "You are now a developer"

## Step 2: Enable USB Debugging
1. Go to **Settings → Developer Options**
2. Toggle **USB Debugging** → ON
3. (Optional) Enable **Install via USB** if available

## Step 3: Connect Phone to PC
1. Plug your phone into your PC via USB cable
2. On the phone popup, select **"Allow USB Debugging"** → tap **Allow**
3. Choose **File Transfer / MTP** mode (not charging only)

## Step 4: Verify Device is Detected
Open terminal and run:
```bash
flutter devices
```
You should see your device listed. If not, try:
```bash
adb devices
```

## Step 5: Run the App
```bash
cd e:\Driver_app
flutter run
```
If multiple devices are connected, specify yours:
```bash
flutter run -d <device_id>
```

---

## Troubleshooting

| Issue | Fix |
|-------|-----|
| Device not detected | Install OEM USB drivers for your phone brand |
| `adb` not found | Add `Android/Sdk/platform-tools` to system PATH |
| Build fails on SDK version | Run `flutter doctor` and follow suggestions |
| App installs but crashes | Run `flutter run --verbose` to see detailed logs |

## Useful Commands
```bash
flutter doctor       # Check environment setup
flutter clean        # Clean build cache if errors occur
flutter run --release # Run optimized release build
```
