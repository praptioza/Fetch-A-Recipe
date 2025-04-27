# Fetch-A-Recipe

## Summary

**Fetch-A-Recipe** is a SwiftUI iOS application that fetches recipe data from an API and displays a list of recipes to the user. It showcases modern iOS development techniques like Swift Concurrency (async/await) and improves the app performance with caching and clean architecture. 
Users can load a list of recipes, view recipe details for each recipe, and refresh the content on demand.

**Key Features:**

- **Recipe List:** Displays a list of recipes with each recipe’s **name**, **cuisine type**, and a thumbnail **photo**. This list is the first view that is displayed when the app is launched.
- **Manual Refresh:** Allows the user to manually refresh the recipe list.
- **Recipe Details:** Tapping on a recipe shows a detail view with more information like an **image of the recipe**, a **link to the recipe**, and a **youtube link**.
- **Image Caching:** Custom image caching system (in-memory and on-disk) ensures images load quickly and are reused without repeated network calls.
- **Error Handling:** Handles errors such as network issues or empty/malformed API responses by showing error messages.
- **Swift Concurrency:** Built using Swift’s async/await for all asynchronous operations.

---

## Focus Areas

- **Swift Concurrency (async/await):** All network calls and data fetching and loading use Swift's concurrency features. Using **async/await** throughout the codebase amkes asynchronous code easier to maintain. This included data fetching, decoding, loading, a repsonsive UI, all without blocking the main thread. This was possible as network fetches and image loading happened in the background using async/await.
  
- **Efficient Image Caching:** Implemented manual caching layer for recipe images. Iamges are cached in memory for faster reuse and also saved to the disk to persist them between new launches. The custom cache, instead of using URLCache, gave control over caching behavior. It avoids redundant image downloads.
  
- **Error Handling:** Error handling is built in to deal with failures like no internet connection, server returning malformed JSON, returned empty list of recipes etc. The UI presents a friendly error message and a retry option when something goes wrong. Error logic is in the ViewModel to ensure that views remain simple and app fails without crashes.

- **Clean SwiftUI Architecture:** This project follows MVVM (Model-View-ViewModel) architecture. In this architecture, SwiftUI views are free of backend logic, a ViewModel handles state and business logic. This makes the code easier to test and maintain. The overall structure is simple and also makes use of @State, @StateObject, @MainActor, ObservableObject, to make data communication and passing easy and systematic and keeps the code organized. The ViewModel handles data fetching (network requests), state management and is annotated with @MainActor to ensure that UI state updates happen on main thread. Views observe ViewModel using @StateObject and automatically update when the data changes.

- **Testing:** The app includes a testing module with all the unit tests and UI tests. It includes unit tests for components such as the recipe fetching logic and image cache, in order to verify that they behave correctly under all conditions. UI Tests are for simulating user interaction and flows like launching the app, refreshing, list navigation, tapping on recipe, to ensure that the UI and navigation work as expected.

- **Platform:** The app is built with SwiftUI and targets iOS 16+. It is developed with Swift 5.10, latest XCode 2025. No third-party libraries are being used, all functioanlity is implemented with Swift's native libraries like Foundation for network fetching and caching and SwiftUI for UI.

---

## Time Spent

- **Total:** ~15 hours (3 hours/day across 5-6 days)
- **Breakdown:**
  - Networking & Concurrency(~3 hours): setting up model structure for corresponding JSON data of API, setting up networking layer in order to fetch recipes from the API asynchronously using async/await, error handling.
  - Image Caching System(~3 hours): developing the custom image caching system using an in-memory cache(eg, NSCache) for quick retrieval and writing to the disk to save images to the file system. Loading images from cache or disk whenever available, to reduce network usage.
    
  - UI Design(~3 hours): building user interface using SwiftUI, cerating each individual row view, list view for all recipes, detail view for each recipe when navigated from the list, and styling.
 
  - Testing (Unit & UI)(~3 hours): deciding what components to test, writing test cases for core functionalities like data fetching, image caching. UITests for simulating and testing user interactions like loading recipes, tapping on a recipe, navigating to detail view, tapping links, reloading recipes.
    
  - Debugging(~2 hours): troubleshooting bugs and edge cases, throughout the development lifecycle whenever needed.

---

## Trade-offs and Decisions

- **Simplified UI:** I chose to prioritize simple, clean interface and focus on core functionality and custon mechanisms, instead of complex UI navigations and designs. As the app is simple with less number of features and functions, like a single list and detail view, I chose to keep it simple and focus on time scope, and core logic.
  
- **Manual Disk Caching:** Instead of relying on built-in cache URLCache for image caching, a custom solution was implemented. the trade-off is additional code complexity.

- **No Third-Party Libraries:** No use of external libraries for anything, keeping the project lightweight potentially adding more code for things that libraries could provide.
  
---

## Weakest Part of the Project

- No cache expiration policy: The memory cache (NSCache) supports automatic eviction, but the disk cache currently does not implement expiration or eviction based on size. Cached images on disk can stay indefinitely unless manually removed. A future enhancement can be a cache with an eviction policy like deleting images older than a certain age or limiting the disk usage. Example: check image file's creation date on disk, if the creation date is greater than 7 days then delete those iamges from disk, or limit disk cache size to 100 MB and delete everything if it exceeds 100 MB.

- **Retry logic:** If a recipe fetch or image download fails due to some reason, the app requires the user to manually refresh using the refresh button or by pulling the list down by holding and releasing for refreshing. There is no automatic retry. Implementing an automatic retry would enhance the experience.
---

## Additional Information

- **Architecture:** MVVM with clear separation between models, views, and viewmodels.
- **Testing:** Unit tests for data fetching and image caching, plus basic UI tests.
- **Swift Version:** Swift 5.10
- **Deployment Target:** iOS 16+
- **Dependencies:** Only Apple's native frameworks are used. No external libraries.
- **Modern Practices:** `@MainActor`, actor-based isolation for services, SwiftUI reactive bindings.

_See the provided screenshots and/or demo video for a quick visual overview._

---

# Thank you!

I enjoyed building this project and focusing on modern Swift techniques, clean architecture, and performance-conscious iOS development.
