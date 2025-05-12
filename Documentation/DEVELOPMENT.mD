# Project Overview and Context

Composa is an iOS/iPadOS app that transforms Apple devices into professional UVC camera monitors. Unlike the original AVCam sample (which focuses on photo/video capture with built-in cameras), Composa is designed for external camera monitoring, explicit device selection, and a minimal, monitor-focused UI. Key differences include:
- Explicit device discovery and selection (including external UVC/USB-C cameras)
- Monitoring and preview overlays ("No Signal", device info, etc.)
- Robust handling of device connection/disconnection
- UI states for searching, device selection, and error handling
- Targeted at creators, videographers, and professionals needing mobile monitoring

# Last Session Summary

- Main focus: Device disconnection handling and overlay flickering
- Achievements: Device disconnection is detected, and a "No Signal" overlay is shown
- Issue: Overlay flickers due to state bouncing between running/disconnected
- Decision: User-initiated reconnection preferred (button in overlay to reconnect or select another device)
- UI/UX: Next steps include improving device grouping, navigation flow, and polish per design specs

# Development Status

This document tracks the current development status of Composa.

## Current Implementation

- [x] External camera device selection
- [x] Preview rendering
- [x] Session configuration
- [x] Watch connectivity for preview frames
- [x] Basic UI for device selection and monitoring
- [x] Device disconnection handling (overlay shown, but flickering remains)
- [x] "No Signal" overlay (shown on disconnect)
- [x] UI states for device discovery (searching, found, selection modal)

## In Progress

- [ ] Fix flickering on device disconnection (state bouncing between running/disconnected)
- [ ] UI polish (transitions, grouping iPad cameras, improved messaging)
- [ ] Basic monitor controls
- [ ] Settings and help screens

## Known Issues

1. Flickering overlay when device disconnects (state bounces between running and disconnected)
2. Need monitor-specific controls (focus, exposure, etc.)
3. iPad front/back cameras shown as separate devices (consider grouping)

## Next Steps
(Read step 1 & 2 together to determine best approach)
1. Fix device disconnection flickering
   - Diagnose and debounce state changes between running/disconnected
   - Ensure user-initiated reconnection or device selection (i.e reconnect button in status overlay)
     - May need to revisit structure of status overlay
   - CameraDeviceListView should support stateful search or researching

2. UI polish (to follow design specs)
   - Improved device grouping in camera device list modal
   - Polish and simplify CameraConnectView. i.e a Preview + Status Overlay + Connected Camera infpr 
   - Clearer separation and navigation intent i.e CameraConnectView navigates to CameraMonitorView. Zoom transition

3. Add monitor controls
   - Focus control
   - Exposure adjustment
   - Frame guides/grid overlay

4. Create settings and help screens
   - Settings screen
     - [ ] Camera preferences (resolution, frame rate)
     - [ ] Audio monitoring settings
     - [ ] Watch connectivity options
     - [ ] UI preferences
   - Help/About screen
     - [ ] App version and credits
     - [ ] Quick start guide
     - [ ] Troubleshooting tips
     - [ ] UI element explanations

## Technical Debt

- Refactor CaptureService to better handle device switching
- Improve error handling throughout the app
- Add comprehensive logging

## Checkpoint Summary (Step 6)

- Device disconnection is detected and overlay is shown
- Main issue: Flickering due to state bouncing between running/disconnected
- Next: Fix flickering and implement user-initiated reconnection or device selection

## Note on Step 7 (UI Polish)

- UI polish and further improvements will follow design specs
- Additional context and requirements will be provided in future updates
