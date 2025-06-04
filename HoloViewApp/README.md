# Holo View App Prototype (macOS/iPhone Agent)

This prototype demonstrates a basic layout for a "Holo View" experience. The interface uses SwiftUI to show
translucent, draggable text boxes on top of a live video feed. Each box can be "popped" with a tap to dismiss it. Users can switch between six modes:

1. **Live View** – a TikTok‑style endless feed of short videos.
2. **VR View** – a three‑dimensional scene with floating text boxes.
3. **AR View** – an augmented reality overlay that places text boxes in the real world.
4. **FindMe View** – displays a map with friend locations using FindMe features.
5. **Threads View** – placeholder timeline pulled from the Threads service.
6. **TikTok View** – placeholder feed simulating TikTok shorts.

Each post includes small icons for replying via X/Twitter, Instagram,
Threads, or with a voice recording.

The code is an early starting point and does not connect to real social media APIs yet. FindMe mode simulates friend tracking and can be expanded to use location services.
