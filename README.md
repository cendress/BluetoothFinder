# BluetoothFinder

## Project Overview
BluetoothFinder helps users detect and locate Bluetooth devices in their vicinity. It uses Core Bluetooth to scan for devices, displays them in a list, and allows users to select a device to view its proximity details.

## Architecture
The BluetoothFinder app utilizes the Model-View-ViewModel (MVVM) architecture, which is particularly suited for SwiftUI applications due to its strong support for state management and data binding. 

### Key Components:
- **Model (`BluetoothDevice`)**: Represents the data model for a Bluetooth device, storing properties like name, RSSI, and TX power. The model is a plain Swift structure, making it lightweight and efficient for passing data.
- **ViewModel (`DeviceListViewModel` and `DeviceLocationViewModel`)**: Acts as the intermediary between the views and the model, handling all the logic for device discovery and state changes. The view model is responsible for initiating Bluetooth scanning, responding to updates, and calculating proximity-based changes.
- **View (`DeviceListView` and `DeviceLocationView`)**: Displays the user interface. The views observe the view models and react to changes. This includes rendering lists of devices and dynamically updating proximity visualizations.
- **Services (`BluetoothManager`)**: Manages Bluetooth operations, including scanning for devices. This separation ensures that the Bluetooth-specific code does not clutter the view model, adhering to single responsibility principles.

## Design Decisions
The design of the BluetoothFinder app emphasizes user experience, technical robustness, and maintainability:

### UI/UX Design:
- **Intuitive Interaction**: The app uses color coding (green to red) to visually indicate device proximity.
- **Responsive Feedback**: Dynamic changes in the visual size of an indicator (circle) and haptic feedback intensity provide real-time proximity cues, enhancing the tactile experience.

### Core Bluetooth:
- **Efficient Scanning**: Scanning for Bluetooth devices is optimized to manage battery consumption and performance, only scanning when necessary and stopping the scan when the app is in the background or a device is selected.
- **Robust Error Handling**: The app includes comprehensive error handling for various Bluetooth states (e.g., powered off, unauthorized) to ensure the app behaves predictably under different hardware conditions.

### Haptic Feedback:
- **Engagement and Accessibility**: Provides an additional layer of interaction by giving physical feedback as users navigate closer to or further from a target device. This is particularly useful in noisy environments or for visually impaired users.

### Modular Codebase:
- **Maintainability**: Each component of the architecture is designed to be as independent as possible, making the app easier to update and maintain.
- **Scalability**: The modular design allows for easy addition of new features, such as different types of devices or more complex proximity algorithms.

## Setup Instructions
1. Clone the repository.
2. Open the project in Xcode.
3. Run the app on a compatible device or simulator.

## Screenshots

## Future Improvements
- Enhance the distance calculation algorithm for better accuracy.
- Provide options to filter and sort the device list.
