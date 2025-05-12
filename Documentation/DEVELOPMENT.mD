# Development Status

This document tracks the current development status of Composa.

## Current Implementation

- [x] External camera device selection
- [x] Preview rendering
- [x] Session configuration
- [x] Watch connectivity for preview frames
- [x] Basic UI for device selection and monitoring

## In Progress

- [ ] Device disconnection handling
- [ ] "No Signal" overlay
- [ ] UI states for device discovery
- [ ] Basic monitor controls

## Known Issues

1. When an external camera disconnects, the app falls back to the built-in camera instead of showing an error state
2. Missing proper error states and user feedback
3. Need monitor-specific controls (focus, exposure, etc.)
4. No "No Signal" overlay for unavailable devices

## Next Steps

1. Fix device disconnection handling
   - Modify CaptureService to detect device disconnection without automatic fallback
   - Update UI to show disconnection state

2. Implement UI states from mockups
   - "Searching for devices" state
   - "No devices found" state
   - "Multiple devices found" state
   - Device selection modal

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
