An app for macOS and iPhone that swizzles social media using XR, the open metaverse standard, bitcoin, and AI connectors.

The app concept is outlined as follows:

* The hope of the app is to extend social media into the realm of XR.
  * AI avatars take the place of profile pictures
  * Cryptocurrency is the medium of exchange
  * AR/VR (XR) allows for an overlay between reality and the VR network (previously the Internet)
  * AI connectors attach to agents, agents represent other apps and devices
* **Holo View** presents social posts in translucent, draggable boxes that float on top of a live feed. Tapping a box "pops" it off the screen.
  * Switch between a TikTok‑style live view, a full VR scene, or an AR overlay of the real world.
  * Connect to services such as TikTok, Instagram, and Threads to populate the view.
* Prototype includes dedicated placeholders for TikTok and Threads feeds.
* Each post shows icons for replying via X/Twitter, Instagram, Threads,
  or with a voice message.
* **FindMe integration** adds location sharing so friends appear on a map or AR overlay.

## Repository Layout

This repository groups several "agents" that work together to serve and consume multiverse content:

* `ServerAgent` – a lightweight Python server that hosts Strmml files. Each
  Strmml file is composed of honeycomb-style sectors that link seamlessly to
  neighbors and may include portal URLs. Portals can reference other Strmml
  files or even remote clusters addressed with the `strmml://` scheme. Remote
  clusters may live on other servers located via DNS.
* `HoloViewApp` – the macOS/iPhone client showing the Holo View prototype.
* `WindowsAgent` – placeholder for a Windows client.
* `VRHeadsetAgent` – placeholder for a VR headset client.

The server delivers Strmml markup that the clients will eventually render.
