# Tap Cook

Tap Cook is a bilingual cooking companion for iPhone and Apple Watch, built with SwiftUI. It helps people browse Chinese home cooking recipes and follow one step at a time on the watch.

## Features

- 142 recipes across 13 regional cuisine collections
- 12 dishes with individually written guided steps; the regional catalog uses reusable technique flows
- English and Simplified Chinese interface and voice prompts
- iPhone to Apple Watch cooking session sync, timers, haptics, and pause/resume
- A cooking notebook with completed dishes, time, streaks, ratings, and notes

The AI caption entry is an MVP placeholder and does not call a paid AI service. Camera assistance is not implemented.

## Run locally

1. Install Xcode 26 or later.
2. Open `TapCook.xcodeproj` and choose the `TapCook` scheme.
3. Run on a paired iPhone and Apple Watch simulator, or use the `TapCookWatch` scheme to explore the watch app directly.

The project uses example bundle identifiers and has no fixed Apple development team. To install on physical devices, select your own team and change the bundle identifiers for the iPhone app, watch app, and test target. Keep the watch companion identifier aligned with the iPhone identifier.

To regenerate the Xcode project, install the Ruby `xcodeproj` gem and run `ruby Scripts/generate_xcodeproj.rb`. You can set `DEVELOPMENT_TEAM` in the environment before regenerating if you want that team written into your local project.

## Repository contents

`TapCook/`, `TapCookWatch/`, and `Shared/` contain the app code. `Resources/` contains the recipe images used by the app. `TapCookTests/` contains model and catalog checks. App Store submission materials, local build output, and machine specific Xcode settings are excluded.

## License

MIT. See [LICENSE](LICENSE).
